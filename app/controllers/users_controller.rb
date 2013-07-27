class UsersController < ApplicationController
  before_filter :ensure_facebook_id_and_token_in_params

  def ensure_facebook_id_and_token_in_params
    render_400("facebook_id") unless params[:facebook_id].kind_of? String
    render_400("facebook_token") unless params[:facebook_token].kind_of? String
  end

  def render_400 param_name
    render :json => { :reason => "#{param_name} not valid" },
           :status => 400
  end

  def login
    if User.facebook_token_matched? params[:facebook_id], params[:facebook_token]
      user = User.find_or_create :facebook_id => params[:facebook_id],
                                 :facebook_token => params[:facebook_token]
      session[:user_id] = user.id
      render :json => user
    else
      session[:user_id] = nil
      render :json => { :reason => "facebook id and token not matched" },
             :status => 409
    end
  end
end
