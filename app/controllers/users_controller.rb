class UsersController < ApplicationController
  before_filter :correct_user, except: [:new, :create, :forgot, :reset ]
  before_filter :admin_user, only: [:destroy]
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = t(:profile_updated)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = t(:welcome)
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t(:deleted_success)
    redirect_to root_path
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || signed_in? && current_user.admin?
  end

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:notice] = I18n.t("reset_code_sent_to", email: user.email)
        redirect_back_or('/')
      else
        flash[:error] = I18n.t("mail_does_not_exist_in_system", email: params[:user][:email])
      end
    end
  end
  
  def reset
    @reset_code = params[:reset_code]
    @user = User.find_by_reset_password_token(@reset_code) unless @reset_code.nil?
    redirect_back_or('/') if @user.nil?
    if request.put?
      if @user.reset_password(@reset_code, params[:user][:password], params[:user][:password_confirmation])
        sign_in @user
        flash[:success] = t(:password_has_been_reset_successfully)
        redirect_to @user
      else
        render :action => :reset
      end
    end    
  end
end
