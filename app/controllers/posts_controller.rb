class PostsController < ApplicationController

  # 1. set up instance variable for action
  before_action :set_post, only: [:show, :edit, :update, :vote]

  # 2. redirect based on some condition
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

####################### DISPLAYING EXISTING POSTS #######################
  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
    #binding pry
  end

  def show
    @comment = Comment.new
    @category = Category.new
    render :show  #this would have happened by default anyways
  end

####################### MAKE A NEW POST #######################

  def new #show the post form
    @post = Post.new
  end

  def create #handle the submission of the new post form   
    @post = Post.new(post_params)
    @post.creator = current_user #TODO change once we have authentication

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_path(@post)
    else # validation error
      render :new
    end
  end

####################### MODIFY AN EXISTING POST #######################

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

####################### VOTE ACTION #######################

  def vote

    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if !@vote.errors.any? #instead of @votes.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on \"#{@post.title}\" once."
          #flash[:error] = "You can only vote on <strong>that</strong> once.".html_safe
        end
        redirect_to :back #whatever your referral is, go back to that url
      end
      format.js do
        render :vote
      end
    end
  end

####################### PRIVATE POSTS CONTROLLER METHODS #######################
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
   # @post = Post.find(params[:id])
   @post = Post.find_by(slug: params[:id])
  end

  def post_edit_denied
    flash[:error] = "Sorry, only the creator of the post can edit!"
    redirect_to root_path
  end
  
  def require_creator
    #if logged_in? and (current_user.admin? || (current_user.username == post.creator.username))
    #post_edit_denied if !logged_in? and (current_user != @post.creator)
    post_edit_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end

end
