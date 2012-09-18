class SchedulesController < ApplicationController
  include SprinklersHelper
  include IceCube
  
  before_filter :valid_sprinkler
  before_filter :user_can_show_sprinkler
  before_filter :valid_schedule, except: [:new, :create]
  
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
    @sprinkler.valves.each{|v| @plan.valf_plans.build({valf:v, enabled:false})}
  end
  
  def edit
    valf_plans_valves_ids = @plan.valf_plans_valves_ids
    @sprinkler.valves.each{|v| @plan.valf_plans.build({valf:v, enabled:false}) unless valf_plans_valves_ids.include?(v.id) }
    @plan.valf_plans.sort!{ |a,b| a.valf.port_index <=> b.valf.port_index}
    logger.debug valf_plans_valves_ids
  end
  
  def update
    if @plan.update_attributes(params[:sprinkler_plan])
      flash[:success] = t(:plan_updated)
      redirect_to @sprinkler
    else
      edit
      render 'edit'
    end    
  end

  def destroy
    @plan.destroy
    flash[:success] = t(:deleted_success)
    redirect_to @sprinkler
  end

  protected
      
  def valid_schedule
    @plan = @sprinkler.sprinkler_plans.find_by_id(params[:id])
    redirect_to @sprinkler unless @plan
  end
 
end
