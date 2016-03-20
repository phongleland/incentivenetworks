class Api::V1::ConsumersController < ApplicationController
  respond_to :json

  def show
    respond_with Consumer.find(params[:id])
  end
end
