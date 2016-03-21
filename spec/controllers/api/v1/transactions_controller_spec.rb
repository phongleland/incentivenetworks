require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  before(:each) {
    request.headers['Accept'] = "#{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  }
  
  describe "GET #show" do
    before(:each) do
      @transaction = FactoryGirl.create :transaction
      get :show, id: @transaction.id
    end

    it "returns the information about a transaction" do
      expect(json_response[:sale_amount]).to eql @transaction.sale_amount.to_s
    end

    it { should respond_with 200 }
  end
  
  describe "GET #index" do
    before(:each) do
      10.times { FactoryGirl.create :transaction }
      get :index
    end

    it "returns 10 records from the database" do
      expect(json_response).to have(10).items
    end

    it { should respond_with 200 }
  end
  
  describe "POST #create" do
    let (:consumer) { FactoryGirl.create :consumer }
    let (:merchant) { FactoryGirl.create :merchant }
    
    context "when successful" do
      before(:each) do
        @valid_attributes = FactoryGirl.attributes_for :transaction
        @valid_attributes[:consumer_id] = consumer.id
        @valid_attributes[:merchant_id] = merchant.id
        post :create, { transaction: @valid_attributes }
      end

      it "renders the json representation" do
        expect(json_response[:sale_amount]).to eql @valid_attributes[:sale_amount].to_s
      end

      it { should respond_with 201 }
    end

    context "when failed" do
      before(:each) do
        @invalid_attributes = FactoryGirl.attributes_for :transaction
        @invalid_attributes[:consumer_id] = consumer.id
        @invalid_attributes[:merchant_id] = merchant.id
        @invalid_attributes[:sale_date] = nil
        post :create, { transaction: @invalid_attributes }
      end

      it "renders the json errors" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on why the transaction could not be created" do
        expect(json_response[:errors][:sale_date]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
end
