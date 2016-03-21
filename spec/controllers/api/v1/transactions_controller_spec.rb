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
end
