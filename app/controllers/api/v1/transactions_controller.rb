class Api::V1::TransactionsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Transaction.all  
  end
  
  def show
    respond_with find_transaction
  end
  
  def create
    transaction = Transaction.new(transaction_params)
    if transaction.save
      render json: transaction, status: 201, location: [:api, transaction]
    else
      render json: { errors: transaction.errors }, status: 422
    end
  end
  
  private
    
    def find_transaction
      Transaction.find(params[:id])
    end
    
    def transaction_params
      params.require(:transaction).permit(:sale_date, :sale_amount, :consumer_id, :merchant_id )
    end
end
