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
end
