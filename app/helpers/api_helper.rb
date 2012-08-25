module ApiHelper
  def valid_api_key
    # redirect_to root_path unless params[:api_key] == Rails.configuration.sprinklers_api_key
  end
end
