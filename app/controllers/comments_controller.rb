class CommentsController < ApplicationController
  def create
    #binding.pry

    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) #stop assignment, mass assigning body
             # Comment.new(params.require(:comment).permit(:body)) #stop assignment, mass assigning body
             # @post.comments.new(params.require(:comment).permit(:body))
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    
    params.require(:comment).permit(:body)

    #if user.admin?
    #  params.require(:post).permit!
    #else
    #  params.require(:post).permit(:title, :url)
    #end
  end

end

# redirect -> URLs
# render -> template file