class ValvesController < ApplicationController
  include SprinklersHelper
  include ApiHelper

  before_filter :valid_sprinkler
  before_filter :valid_valf, except: [:new, :create, :index]

  before_filter :user_can_show_sprinkler, :except => [:show, :new_irregation, :create_irregation]
  before_filter(:only => [:show, :new_irregation, :create_irregation]) do |controller|
    if controller.request.format.json?
      valid_api_key
    else
      user_can_show_sprinkler
    end
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

  def new_irregation
    @valf_irregation = @valf.valf_irregations.build
  end
  
  def create_irregation
    respond_to do |format|
      @valf_irregation = @valf.valf_irregations.build(params[:valf_irregation])
      if @valf_irregation.save
        # Send OK to user        
        format.json { render "create_irregation_ack" }
        format.html do
          flash[:success] = t(:reading_created)
          redirect_to action: "new_irregation"
        end
      else
        format.json { render "create_irregation_err", :status => :bad_request }
        format.html do
          flash[:error] = t(:could_not_create_reading)
          render action: "new_irregation"
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
