class SprinklersController < ApplicationController
  include SprinklersHelper
  
  before_filter :valid_sprinkler, except: [:new, :index]
  before_filter :user_can_show_sprinkler, except: [:new, :index, :show]
  before_filter only: :show do |c|
    logger.debug "------------------" + c.request.format.to_s
    user_can_show_sprinkler unless c.request.format.json?
  end # TODO - add verification for json.
  before_filter :admin_user, only: [:new, :edit, :create, :update, :destroy]
  
  def new
    @sprinkler = Sprinkler.new
  end

  def create
    @sprinkler = Sprinkler.new(params[:sprinkler]);
    if @sprinkler.save
      flash[:success] = t(:sprinkler_created)
      redirect_to @sprinkler
    else
      flash[:error] = t(:could_not_create_sprinkler)
      render action: :new
    end
  end


  def index
  end

  def show
    respond_to :html, :json
  end

  def edit
  end

  def update
    if @sprinkler.update_attributes(params[:sprinkler])
      flash[:success] = t(:sprinkler_created)
      redirect_to @sprinkler
    else
      flash[:error] = t(:could_not_create_sprinkler)
      render 'edit'
    end
    
  end

  def destroy
  end

end
