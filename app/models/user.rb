class User < ActiveRecord::Base
  FB_GRAPH_URL = "https://graph.facebook.com"
  include HTTParty
  attr_accessible :facebook_id, :facebook_token
  has_and_belongs_to_many :bands, :join_table => :users_bands

  def self.facebook_token_matched? facebook_id, facebook_token
    response = get("#{FB_GRAPH_URL}/me?access_token=#{facebook_token}")

    user_data = JSON.parse(response.body)
    user_data["id"] == facebook_id
  end
end
