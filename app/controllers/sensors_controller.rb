class SensorsController < ApplicationController
  include SprinklersHelper

  before_filter :valid_sprinkler
  before_filter :user_can_show_sprinkler, only: [:show]
  before_filter :valid_api_key, only:[:create] # A machine api key validation
  before_filter :valid_sensor
  def new_reading
    @sensor_reading = @sensor.sensor_readings.build
  end

  def create_reading
    respond_to do |format|
      format.json do
        logger.debug params.to_yaml

        # skip_before_filter :authenticate_user!
        @sensor_reading = @sensor.sensor_readings.build(params[:sensor_reading]);
        if @sensor_reading.save
          render "sensor_reading_ack"
        else
          render "sensor_reading_err", :status => :bad_request
          logger.debug @sensor_reading.errors.to_yaml
        end
      end

      format.html do
        @sensor_reading = @sensor.sensor_readings.build(params[:sensor_reading]);
        if @sensor_reading.save
          flash[:success] = t(:reading_created)
          redirect_to action: "new_reading"
        else
          flash[:error] = t(:could_not_create_reading)
          render action: "new_reading"
        end
      end
    end
  end

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

  def valid_sensor
    @sensor_id = params[:id]
    redirect_to root_path unless @sensor_id
    @sensor = @sprinkler.sensors.find_by_id @sensor_id
    redirect_to root_path unless @sensor
  end

  def valid_api_key
    # redirect_to root_path unless params[:api_key] == Rails.configuration.sprinklers_api_key
  end

end
