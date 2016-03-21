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
  
  describe "POST #create" do
    context "when successful" do
      before(:each) do
        @valid_attributes = FactoryGirl.attributes_for :consumer
        post :create, { consumer: @valid_attributes }
      end

      it "renders the json representation" do
        consumer_response = JSON.parse(response.body, symbolize_names: true)
        expect(consumer_response[:firstname]).to eql @valid_attributes[:firstname]
      end

      it { should respond_with 201 }
    end

    context "when failed" do
      before(:each) do
        @invalid_attributes = { firstname: "John", lastname: nil }
        post :create, { consumer: @invalid_attributes }
      end

      it "renders the json errors" do
        consumer_response = JSON.parse(response.body, symbolize_names: true)
        expect(consumer_response).to have_key(:errors)
      end

      it "renders the json errors on why the consumer could not be created" do
        consumer_response = JSON.parse(response.body, symbolize_names: true)
        expect(consumer_response[:errors][:lastname]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
end
