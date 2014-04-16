class SessionsController < ApplicationController

####################### CREATE A SESSION #######################
  def new
    
  end

  def create
    #ex. user.authenticate('password')
    #1 get the user obj
    #2 see if password matches
    #3 if so, log in
    #4 if not, error message

    user = User.find_by(username: params[:username])
    #alternative syntax is: user = User.where(username: params[:username].first)

    #binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # information here stored in browser cookie
      # save only the user_id and not the entire user object, cookies can only accomodate 4KBs of data
      flash[:notice] = "Welcome, you've logged in!"
      redirect_to root_path
    else
      flash[:error] = "There's something wrong with your username or password."
      redirect_to signin_path
      #flash.now[:error] = "There's something wrong with your username or password."
      #render :new
    end

  end

####################### DESTROY A SESSION #######################

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path #login_path
  end

end 