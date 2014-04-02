class PostsController < ApplicationController

  # 1. set up instance variable for action
  before_action :set_post, only: [:show, :edit, :update]

  # 2. redirect based on some condition

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    render :show  #this would have happened by default anyways
  end

  def new #show the post form
    @post = Post.new
  end

  def create #handle the submission of the new post form
    
    @post = Post.new(post_params)
    @post.creator = User.first #TODO change once we have authentication

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_path(@post)
    else #validation error
      render :new
    end
  end

  def edit #display the edit post form /posts/:id/edit
  end

  def update #handle the submission of that edit post form
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    
    params.require(:post).permit!

    #if user.admin?
    #  params.require(:post).permit!
    #else
    #  params.require(:post).permit(:title, :url)
    #end
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
