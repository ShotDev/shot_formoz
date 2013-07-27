class BandsController < ApplicationController
  before_filter :ensure_user_loggedin, 
                :ensure_band_ids_exists, 
                :only => :create

  def ensure_user_loggedin
    if session[:user_id] != params[:user_id]
      render :json => { :reason => "user not authorized." },
             :status => 401
      return false
    end
    true
  end

  def ensure_band_ids_exists
    render_400 "band_ids" unless params[:band_ids].kind_of? Array
  end

  def render_400 param_name
    render :json => { :reason => "#{param_name} not valid" },
           :status => 400
  end

  def index
    if params[:user_id]
      return unless ensure_user_loggedin
      user = User.where(:id => params[:user_id]).first
      render :json => user.bands
    else
      render :json => Band.all
    end
  end

  def create
    user = User.where( :id => params[:user_id] ).first
    user.band_ids = params[:band_ids]
    render :json => user.bands
  rescue ActiveRecord::RecordNotFound => err
    render :json => { :reason => err.message },
      :status => 404
  end
end
