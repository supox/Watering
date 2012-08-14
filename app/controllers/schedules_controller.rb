class SchedulesController < ApplicationController
  include SprinklersHelper
  include IceCube
  
  before_filter :valid_sprinkler
  before_filter :user_can_show_sprinkler

  def create
    @plan = @sprinkler.sprinkler_plans.build
    schedule = Schedule.new(Time.now)
    case params[:repeat] 
    when "Daily"
      schedule.rrule Rule.daily
    when "Weekly"
      day_values = Date::ABBR_DAYNAMES
      day_values.each_with_index do |val,i|
        if params[:weekly][val]=="1"
             schedule.rrule Rule.daily.day(i)
        end
      end
    when "Monthly"
      day = params[:day_of_month]
      schedule.rrule Rule.monthly.day_of_month(day)
    else
      flash[:error] = "Could not create plan."
      render 'new'
      return
    end
 
    @plan.schedule = schedule
    
    if @plan.save
      flash[:success] = "Plan created!"
      redirect_to @sprinkler
    else
      flash[:error] = "Could not create plan."
      render 'new'
    end
  end
  
  def new
    @plan = @sprinkler.sprinkler_plans.build
  end
  
end
