class ValvesController < ApplicationController
  include SprinklersHelper

  before_filter :valid_sprinkler
  before_filter :valid_valf, except: [:new, :create, :index]

  before_filter :user_can_show_sprinkler, :except => [:show, :new_irrigation, :create_irrigation, :index]
  before_filter(:only => [:show, :new_irrigation, :create_irrigation, :index]) do |controller|
    can_show_sprinkler(controller.request.format)
  end

  def new
    @valf = @sprinkler.valves.build
  end

  def create
    @valf = @sprinkler.valves.build(params[:valf]);
    if @valf.save
      flash[:success] = t(:valf_created)
      redirect_to action: :new
    else
      flash[:error] = t(:could_not_create_valf)
      render action: :new
    end
  end

  def edit
  end

  def update
    if @valf.update_attributes(params[:valf])
      flash[:success] = t(:valf_created)
      redirect_to sprinkler_valf_path(@sprinkler,@valf)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @valf.destroy
    flash[:success] = t(:deleted_success)
    redirect_to @sprinkler
  end
  
  def index
    @valves = @sprinkler.valves
  end

  def new_irrigation
    @valf_irrigation = @valf.valf_irrigations.build
  end
  
  def create_irrigation
    respond_to do |format|
      @valf_irrigation = @valf.valf_irrigations.build(params[:valf_irrigation])
      if @valf_irrigation.save
        # Send OK to user        
        format.json { render "create_irrigation_ack" }
        format.html do
          flash[:success] = t(:reading_created)
          redirect_to action: "new_irrigation"
        end
      else
        format.json { render "create_irrigation_err", :status => :bad_request }
        format.html do
          flash[:error] = t(:could_not_create_reading)
          render action: "new_irrigation"
        end
      end
    end
    
  end
  
  protected

  def valid_valf
    @valf_id = params[:id]
    if @valf_id
      @valf = @sprinkler.valves.find_by_id @valf_id
      redirect_to root_path unless @valf
    else
      redirect_to root_path
    end
  end
end
