class TimeController < ApplicationController
  def index
    @time = {Time: Time.zone.now.to_i};
  end
end
