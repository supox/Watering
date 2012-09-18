class SensorsController < ApplicationController
  include SprinklersHelper
  include ApiHelper

  before_filter :valid_sprinkler
  before_filter :valid_sensor, except:[ :new, :create, :index ]
  before_filter :user_can_show_sprinkler, except:[ :create_reading, :index ]  
  before_filter only: [:create_reading, :index] do |c|
    if c.request.format.json?
      valid_api_key
    else
      user_can_show_sprinkler
    end
  end
  
  def index
    @sensors = @sprinkler.sensors
    @alarms = @sprinkler.alarms
  end

  # Sensors Reading
  def new_reading
    @sensor_reading = @sensor.sensor_readings.build    
  end

  def create_reading
    respond_to do |format|
      @sensor_reading = @sensor.sensor_readings.build(params[:sensor_reading])
      if @sensor_reading.save
        
        # Check all alarms if need to notify by mail 
        @sensor.alarms.each do |alarm|
          if(alarm.will_alarm?(@sensor_reading.sensor_value))
            AlarmMailer.alarm_email(alarm).deliver
          end
        end

        # Send OK to user        
        format.json { render "sensor_reading_ack" }
        format.html do
          flash[:success] = t(:reading_created)
          redirect_to action: "new_reading"
        end
      else
        format.json { render "sensor_reading_err", :status => :bad_request }
        format.html do
          flash[:error] = t(:could_not_create_reading)
          render action: "new_reading"
        end
      end
    end
  end

  # Sensors restful
  def show
    days_to_plot = (params[:time_ago] || 7).to_i
    date_to_plot = days_to_plot.days.ago

    sensor_readings = @sensor.sensor_readings.all(:conditions => ["read_time >= ?", date_to_plot])
    @data = sensor_readings.collect{|reading| {
      date: reading.read_time,
      value:reading.sensor_value.to_i,
      } }
    logger.debug @data.to_yaml

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @sensor = @sprinkler.sensors.build
  end

  def create
    @sensor = @sprinkler.sensors.build(params[:sensor]);
    if @sensor.save
      flash[:success] = t(:sensor_saved)
      redirect_to action: :new
    else
      flash[:error] = t(:could_not_create_sensor)
      render action: :new
    end
  end

  def edit
  end

  def update
    if @sensor.update_attributes(params[:sensor])
      flash[:success] = t(:sensor_saved)
      redirect_to action: :show
    else
      render 'edit'
    end
  end

  def destroy
    @sensor.destroy
    flash[:success] = t(:deleted_success)
    redirect_to @sprinkler
  end

  protected

  def valid_sensor
    @sensor_id = params[:id]
    if @sensor_id
      @sensor = @sprinkler.sensors.find_by_id @sensor_id
      redirect_to root_path unless @sensor
    else
      redirect_to root_path
    end
  end
end
