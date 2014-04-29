class CommentsController < ApplicationController

 # 2. redirect based on some condition
before_action :require_user
  
####################### CREATE A COMMENT #######################
  def create
    #binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) #mass assign via strong parameters
             # Comment.new(params.require(:comment).permit(:body)) #stop assignment, mass assigning body
             # @post.comments.new(params.require(:comment).permit(:body))
    #@comment = Comment.new(params.require(:comment).permit(:body))
    #@comment.post = @post
    @comment.creator = current_user         
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

####################### VOTE ACTION #######################

  def vote
    #binding.pry
    
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    #@vote = Vote.create(voteable_type: "Comment", voteable_id: params[:id]) 
    respond_to do |format|
      format.html do
        if !@vote.errors.any? #instead of @votes.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on \"#{@comment.body}\" once."
          #flash[:error] = "You can only vote on <strong>that</strong> once.".html_safe
        end
        redirect_to :back #whatever your referral is, go back to that url
      end
      format.js do
        render :vote
      end
    end

  end

private

####################### PRIVATE COMMENTS CONTROLLER METHODS #######################

  def comment_params
    params.require(:comment).permit(:body)
  end

end

# redirect -> URLs
# render -> template file