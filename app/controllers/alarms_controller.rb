class AlarmsController < ApplicationController
  include SprinklersHelper

  before_filter :valid_sprinkler
  before_filter :valid_sensor
  before_filter :user_can_show_sprinkler, except: [:index]
  before_filter only: [:index] do |c|
    can_show_sprinkler(c.request.format)
  end

  before_filter :valid_alarm, except: [:new, :create, :index]

  def index
    respond_to do |format|
      format.html {@alarms = @sensor.alarms.paginate(page: params[:page])}
      format.json {@alarms = @sensor.alarms.first(1000)}
    end
  end
  
  def new
    @alarm = @sensor.alarms.build
  end

  def create
    @alarm = @sensor.alarms.build(params[:alarm])
    if @alarm.save
      flash[:success] = t(:alarm_saved)
      redirect_to action: :new
    else
      flash[:error] = t(:could_not_create)
      render action: :new
    end
  end

  def edit
  end

  def update
    if @alarm.update_attributes(params[:alarm])
      flash[:success] = t(:changes_saved)
      redirect_to action: :show
    else
      render 'edit'
    end
  end

  def destroy
    @alarm.destroy
    flash[:success] = t(:deleted_success)
    redirect_to sprinkler_sensor_path(@sensor.sprinkler_id, @sensor)
  end

protected
  def valid_sensor
    @sensor_id = params[:sensor_id]
    if @sensor_id
      @sensor = @sprinkler.sensors.find_by_id @sensor_id
      redirect_to root_path unless @sensor
    else
      redirect_to root_path
    end
  end
  
  def valid_alarm
    @alarm_id = params[:id]
    if @alarm_id
      @alarm = @sensor.alarms.find_by_id @alarm_id
      redirect_to root_path unless @alarm
    else
      redirect_to root_path
    end
  end

end
