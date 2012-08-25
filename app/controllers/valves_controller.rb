class ValvesController < ApplicationController
  include SprinklersHelper
  include ApiHelper

  before_filter :valid_sprinkler
  before_filter :valid_valve, except: [:new, :create]

  before_filter(:only => :show) do |controller|
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
      redirect_to @valf
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
  
  protected

  def valid_valve
    @valf_id = params[:id]
    if @valf_id
      @valf = @sprinkler.valves.find_by_id @valf_id
      redirect_to root_path unless @valf
    else
      redirect_to root_path
    end
  end
end
