class SchedulesController < ApplicationController
  include SprinklersHelper
  include IceCube
  
  before_filter :valid_sprinkler
  before_filter :user_can_show_sprinkler
  before_filter :valid_schedule, only: [:edit, :update]
  
  def create
    @plan = @sprinkler.sprinkler_plans.build(params[:sprinkler_plan])
    
    if @plan.save
      flash[:success] = t(:plan_created)
      redirect_to @sprinkler
    else
      flash[:error] = t(:could_not_create_plan)
      render 'new'
    end
  end
  
  def new
    @plan = @sprinkler.sprinkler_plans.build
  end
  
  def edit
  end
  
  def update
    if @plan.update_attributes(params[:sprinkler_plan])
      flash[:success] = t(:plan_updated)
      redirect_to @sprinkler
    else
      render 'edit'
    end    
  end
    
  def valid_schedule
    @plan = @sprinkler.sprinkler_plans.find_by_id(params[:id])
    redirect_to @sprinkler unless @plan
  end
  private
  
end
