class Api::V1::TransactionsController < ApplicationController
  respond_to :json
  
  def show
    respond_with find_transaction
  end
  
  private
    
    def find_transaction
      Transaction.find(params[:id])
    end
end
