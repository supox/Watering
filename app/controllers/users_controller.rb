class UsersController < ApplicationController
  before_filter :correct_user, except: [:new, :create]
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

end
