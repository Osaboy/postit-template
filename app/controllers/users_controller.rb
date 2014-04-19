class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update]
before_action :require_same_user, only: [:edit, :update]

####################### MAKE A NEW POST #######################  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Congratulatons, You are registered!"
      redirect_to root_path
    else
      render :new
    end
  end

####################### DISPLAYING USER PROFILE #######################

  def index

  end

  def show
    #binding.pry
  #      @user = current_user 
  #      render :show
  #  else
  #    flash[:error] = "Please sign in"
   #   render 'sessions/new'
   # end 
  end

####################### MODIFY AN EXISTING USER #######################

  def edit
    if logged_in?
        @user = current_user 
        render :edit
    else
      flash[:error] = "Please sign in"
      render 'sessions/new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated"
      render :show
    else
      render :edit
    end
  end

####################### PRIVATE USERS CONTROLLER METHODS #######################
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:username, :password)
  end

  def require_same_user
    if current_user.username != @user
      flash[:error] = "You're not allowed to do that"
      redirect_to root_path
    end
  end

end