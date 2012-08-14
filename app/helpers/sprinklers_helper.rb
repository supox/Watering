module SprinklersHelper
  def valid_sprinkler
    id = params[:sprinkler_id] || params[:id]
    @sprinkler = Sprinkler.find(id) 
    redirect_to(root_path) unless @sprinkler    
  end

  def user_can_show_sprinkler
    if( not signed_in? or
        not @sprinkler.users.find_by_id(current_user.id) and not current_user.admin?  
      )
      redirect_to(root_path)
    end
  end  
end
