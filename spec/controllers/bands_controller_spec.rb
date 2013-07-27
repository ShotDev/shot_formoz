require 'spec_helper'

describe BandsController do
  
  describe "GET index" do
    let(:band_number) { 3 }
    before(:each) do
      band_number.times { FactoryGirl.create(:band)  }
    end
    
    it "returns all bands" do
      get :index

      response.should be_success
      JSON.parse(response.body).length.should == band_number 
    end
  end

  describe "POST create" do
    before(:each) do
      band_count = 5
      session[:user_id] = "the-user-id"
      @user = mock_model(User)
      @user.stub(:bands => [])
      User.stub(:where => [ @user ])
      @band_ids = []
      band_count.times do 
        band = FactoryGirl.create :band
        @band_ids << band.id.to_s
      end
    end

    it "creates users_bands relations" do
      @user.should_receive(:band_ids=).with(@band_ids)

      post :create, :band_ids => @band_ids, :user_id => "the-user-id"
    end

    it "returns 401 if user_id and session not matched" do
      post :create, :band_ids => @band_ids, :user_id => "not-matched"

      response.status.should == 401
    end

    it "returns 404 if records not found" do
      @user.should_receive(:band_ids=).with(@band_ids)
        .and_raise(ActiveRecord::RecordNotFound)

      post :create, :band_ids => @band_ids, :user_id => "the-user-id"

      response.status.should == 404
    end

    it "returns 400 if band_ids not provided" do
      post :create, :user_id => "the-user-id"
      
      response.status.should == 400
    end
  end
end
