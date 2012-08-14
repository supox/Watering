class SensorReadingController < ApplicationController
  before_filter :valid_api_key
  before_filter :valid_sensor

  def new
    @sensor_reading = @sensor.sensor_readings.build
  end
  
  def create
    readdatetime = DateTime.new(
                        params[:sensor_reading]["read_time(1i)"].to_i, 
                        params[:sensor_reading]["read_time(2i)"].to_i, 
                        params[:sensor_reading]["read_time(3i)"].to_i, 
                        params[:sensor_reading]["read_time(4i)"].to_i, 
                        params[:sensor_reading]["read_time(5i)"].to_i, 
    )
    @sensor_reading = @sensor.sensor_readings.build(
      sensor_value: params[:sensor_reading][:sensor_value],
      read_time: readdatetime
    );
    
    if @sensor_reading.save
      flash[:success] = t(:reading_created)
      redirect_to action: "new", sensor_id: @sensor_id 
    else
      flash[:error] = t(:could_not_create_reading)
      render action: "new", sensor_id: @sensor_id
    end
  end
  
  def graph
    days_to_plot = (params[:time_ago] || 7).to_i
    date_to_plot = days_to_plot.days.ago

    sensor_readings = @sensor.sensor_readings.all(:conditions => ["read_time >= ?", date_to_plot])
    @data = sensor_readings.collect{|reading| {
      date: reading.read_time,
      value:reading.sensor_value,
      } }
      
    respond_to do |format|
      format.html
      format.js
    end
    
  end

  def valid_sensor
    @sensor_id = params[:sensor_id]
    @sensor_id ||= params[:sensor_reading][:sensor_id]
    redirect_to root_path unless @sensor_id
    @sensor = Sensor.find_by_id @sensor_id
    redirect_to root_path unless @sensor 
  end
    
  def valid_api_key
    # redirect_to root_path unless params[:api_key] == Rails.configuration.sprinklers_api_key
  end
  
end
