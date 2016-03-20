require 'rails_helper'

RSpec.describe Api::V1::ConsumersController, type: :controller do
  before(:each) {
    request.headers['Accept'] = "#{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  }
  
  describe "GET #show" do
    before(:each) do
      @consumer = FactoryGirl.create :consumer
      get :show, id: @consumer.id
    end

    it "returns the information about a consumer" do
      consumer_response = JSON.parse(response.body, symbolize_names: true)
      expect(consumer_response[:firstname]).to eql @consumer.firstname
    end

    it { should respond_with 200 }
  end
  
  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :consumer }
      get :index
    end

    it "returns 4 records from the database" do
      consumers_response = JSON.parse(response.body, symbolize_names: true)
      expect(consumers_response).to have(4).items
    end

    it { should respond_with 200 }
  end
  
end
