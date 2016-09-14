class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user)  if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "invalid_password"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
