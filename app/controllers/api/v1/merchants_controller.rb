class Api::V1::MerchantsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Merchant.all  
  end
  
  def show
    respond_with find_merchant
  end
  
  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      render json: merchant, status: 201, location: [:api, merchant]
    else
      render json: { errors: merchant.errors }, status: 422
    end
  end
  
  def update
    merchant = find_merchant
    if merchant.update(merchant_params)
      render json: merchant, status: 200, location: [:api, merchant]
    else
      render json: { errors: merchant.errors }, status: 422
    end
  end
  
  def destroy
    merchant = find_merchant
    merchant.destroy
    head 204
  end
  
  private
    
    def find_merchant
      Merchant.find(params[:id])
    end
    
    def merchant_params
      params.require(:merchant).permit(:name, :domain)
    end
end
