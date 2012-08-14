class SprinklersController < ApplicationController
  include SprinklersHelper
  
  before_filter :valid_sprinkler, except: [:new]
  before_filter :user_can_show_sprinkler, except: [:new, :edit, :destroy]
  before_filter :admin_user, only: [:new, :edit, :destroy]
  
  def index
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def new
  end   
end
