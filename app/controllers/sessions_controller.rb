class SessionsController < ApplicationController
  def new
  end


  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = t :invalid_email_password_combination
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
