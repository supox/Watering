class SprinklersController < ApplicationController
  include SprinklersHelper
  include ApiHelper
  
  before_filter :valid_sprinkler, except: [:new, :index]
  before_filter :user_can_show_sprinkler, except: [:new, :index, :show, :configuration]
  before_filter only: [:show, :configuration] do |c|
    if c.request.format.json?
      valid_api_key
    else
      user_can_show_sprinkler unless c.request.format.json?
    end
  end
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

  def configuration   
    @configuration = @sprinkler.get_config
    respond_to :html, :json
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
