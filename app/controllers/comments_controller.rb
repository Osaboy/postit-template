class CommentsController < ApplicationController
  
####################### CREATE A COMMENT #######################
  def create
    #binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) #mass assign via strong parameters
             # Comment.new(params.require(:comment).permit(:body)) #stop assignment, mass assigning body
             # @post.comments.new(params.require(:comment).permit(:body))
    #@comment = Comment.new(params.require(:comment).permit(:body))
    #@comment.post = @post
    @comment.creator = User.first         
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
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