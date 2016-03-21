require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  before(:each) {
    request.headers['Accept'] = "#{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  }
  
  describe "GET #show" do
    before(:each) do
      @merchant = FactoryGirl.create :merchant
      get :show, id: @merchant.id
    end

    it "returns the information about a merchant" do
      expect(json_response[:name]).to eql @merchant.name
    end

    it { should respond_with 200 }
  end
  
  describe "GET #index" do
    before(:each) do
      10.times { FactoryGirl.create :merchant }
      get :index
    end

    it "returns 10 records from the database" do
      expect(json_response).to have(10).items
    end

    it { should respond_with 200 }
  end
  
  describe "POST #create" do
    context "when successful" do
      before(:each) do
        @valid_attributes = FactoryGirl.attributes_for :merchant
        post :create, { merchant: @valid_attributes }
      end

      it "renders the json representation" do
        expect(json_response[:name]).to eql @valid_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when failed" do
      before(:each) do
        @invalid_attributes = { name: FFaker::Company.name, domain: nil }
        post :create, { merchant: @invalid_attributes }
      end

      it "renders the json errors" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on why the merchant could not be created" do
        expect(json_response[:errors][:domain]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "PUT/PATCH #update" do
    let (:name) { FFaker::Company.name }
  
    before(:each) do
      @merchant = FactoryGirl.create :merchant
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: @merchant.id,
              merchant: { name: name } }
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:name]).to eql name
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { id: @merchant.id,
              merchant: { name: nil } }
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(json_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @merchant = FactoryGirl.create :merchant
      delete :destroy, { id: @merchant.id }
    end

    it { should respond_with 204 }
  end
end
