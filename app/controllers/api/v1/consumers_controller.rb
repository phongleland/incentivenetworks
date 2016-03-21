class Api::V1::ConsumersController < ApplicationController
  respond_to :json

  def index
    respond_with Consumer.all  
  end
    
  def show
    respond_with find_consumer
  end
  
  def create
    consumer = Consumer.new(consumer_params)
    if consumer.save
      render json: consumer, status: 201, location: [:api, consumer]
    else
      render json: { errors: consumer.errors }, status: 422
    end
  end
  
  def update
    consumer = find_consumer
    if consumer.update(consumer_params)
      render json: consumer, status: 200, location: [:api, consumer]
    else
      render json: { errors: consumer.errors }, status: 422
    end
  end
  
  def destroy
    consumer = find_consumer
    consumer.destroy
    head 204
  end

  private
    
    def find_consumer
      Consumer.find(params[:id])
    end
    
    def consumer_params
      params.require(:consumer).permit(:lastname, :firstname)
    end
end
