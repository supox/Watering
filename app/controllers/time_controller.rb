class TimeController < ApplicationController
  def index
    @time = {Time: Time.now.to_i};
  end
end
