class Api::V1::ConsumersController < ApplicationController
  respond_to :json

  def index
    respond_with Consumer.all  
  end
    
  def show
    respond_with Consumer.find(params[:id])
  end
  
  def create
    consumer = Consumer.new(consumer_params)
    if consumer.save
      render json: consumer, status: 201, location: [:api, consumer]
    else
      render json: { errors: consumer.errors }, status: 422
    end
  end

  private

    def consumer_params
      params.require(:consumer).permit(:lastname, :firstname)
    end
end
