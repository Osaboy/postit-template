class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  # makes the methods available to all the view templates and controllers
  helper_method :current_user, :logged_in?, :require_user

  def current_user
    # if there's an authenticated user, return the user obj
    # else return nil

    #memorization - minor optimization method, if this user exists do not run the rest of the code, the rest of the code hits the database
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    # User.find(nil object) will throw an exception, so this code will execute only if session[:user_id] is not nil

  end

  def logged_in?
    # converts to boolean value, if nil object returns false
    !!current_user
  end

  def require_user # have to redirect
    if !logged_in?
      flash[:error] = "Oops, you must be signed in to perform that action"
      redirect_to root_path
    end
  end

  def require_admin # have to redirect
    #access_denied if !logged_in? || !current_user.admin?
    access_denied unless logged_in? and current_user.admin?
    # check for logged_in? first to make sure that we have a user object   
  end

  def require_moderator # have to redirect
  end

  def access_denied
    flash[:error] = "Sorry, only admins can create new Categories"
    redirect_to root_path
  end

end


