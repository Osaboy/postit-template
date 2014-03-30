class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    render :show  #this would have happened by default anyways
  end

  def new #show the post form

  end

  def create #handle the submission of the new post form

  end

  def edit #display the edit post form

  end

  def update #handle the submission of that edit post form
 
  end


end
