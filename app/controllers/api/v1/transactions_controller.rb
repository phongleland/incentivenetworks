class Api::V1::TransactionsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Transaction.all  
  end
  
  def show
    respond_with find_transaction
  end
  
  private
    
    def find_transaction
      Transaction.find(params[:id])
    end
end
