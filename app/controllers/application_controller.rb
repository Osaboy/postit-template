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

  def require_user
    if !logged_in?
      flash[:error] = "Oops, you must be signed in to perform that action"
      redirect_to root_path
    end
  end

end


