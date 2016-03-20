class Api::V1::ConsumersController < ApplicationController
  respond_to :json

  def index
    respond_with Consumer.all  
  end
    
  def show
    respond_with Consumer.find(params[:id])
  end
end
