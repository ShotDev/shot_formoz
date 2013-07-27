require 'spec_helper'

describe UsersController do

  describe "POST :login" do
    describe "if facebook_id not given" do
      it "returns 400" do
        post :login, :facebook_token => "the-token" 

        response.status.should == 400
      end
    end

    describe "if facebook_token not given" do
      it "returns 400" do
        post :login, :facebook_id => "the-id" 

        response.status.should == 400
      end
    end

    describe "if facebook token-id matched" do
      before(:each) do
        @mock_user = FactoryGirl.create :user
        User.stub(:facebook_token_matched? => true)
        User.stub(:find_or_create => @mock_user)
      end

      it "find or create a user" do
        User.should_receive(:find_or_create).with({
          :facebook_token => "the-token",
          :facebook_id => "the-id"
        })

        post :login, :facebook_token => "the-token", :facebook_id => "the-id"
      end

      it "returns user" do
        post :login, :facebook_token => "the-token", :facebook_id => "the-id"

        JSON.parse(response.body)["id"].should == @mock_user.id
      end

      it "sets session[user_id] to user id" do
        post :login, :facebook_token => "the-token", :facebook_id => "the-id"

        session["user_id"].should == @mock_user.id
      end
    end

    describe "if facebook token-id not matched" do
      before(:each) do
        User.stub(:facebook_token_matched? => false)
      end

      it "clears session[:user_id]" do
        session[:user_id] = "the-previous-user-id"

        post :login, :facebook_token => "the-token", :facebook_id => "the-id"
        
        session[:user_id].should be_nil
      end

      it "returns 409" do
        post :login, :facebook_token => "the-token", :facebook_id => "the-id"

        response.status.should == 409
      end
    end
  end

end
