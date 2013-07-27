require 'spec_helper'

describe User do
  describe "User::facebook_token_matched?" do
    let(:facebook_id) { "the-id" }
    let(:facebook_token) { "the-token" }
    let(:mock_success_response) { stub(:body => { :id => "the-id" }.to_json) }
    let(:mock_failed_response) { stub(:body => { :error => "the-error" }.to_json) }

    it "sends request to facebook with token" do
      User.should_receive(:get).
        with("#{User::FB_GRAPH_URL}/me?access_token=#{facebook_token}").
        and_return(mock_success_response)

      User.facebook_token_matched? facebook_id, facebook_token
    end

    it "returns true if response.id == facebook_id" do
      User.stub(:get => mock_success_response) 

      matched = User.facebook_token_matched? facebook_id, facebook_token

      matched.should == true
    end

    it "returns false if facebook error" do
      User.stub(:get => mock_failed_response)

      matched = User.facebook_token_matched? facebook_id, facebook_token

      matched.should == false
    end
  end
end
