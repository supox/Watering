class SprinklersController < ApplicationController
  include SprinklersHelper

  before_filter :valid_sprinkler, except: [:new, :index]
  before_filter :user_can_show_sprinkler, except: [:new, :index, :show, :configuration, :create_log]
  before_filter only: [:show, :configuration, :create_log] do |c|
    can_show_sprinkler(c.request.format)
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

  def new_log
    @sprinkler_log = @sprinkler.sprinkler_logs.build
  end

  def create_log
    respond_to do |format|
      @sprinkler_log = @sprinkler.sprinkler_logs.build(params[:sprinkler_log])
      if @sprinkler_log.save
        # Send OK to user
        format.json { render "create_log_ack" }
        format.html do
          flash[:success] = t(:reading_created)
          redirect_to action: "new_log"
        end
      else
        format.json { render "create_log_err", :status => :bad_request }
        format.html do
          flash[:error] = t(:could_not_create_reading)
          render action: "new_log"
        end
      end
    end
  end

end
