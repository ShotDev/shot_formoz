class BandsController < ApplicationController
  def index
    render :json => Band.all
  end
end
