Rails.application.routes.draw do

  # use url format /api/v1/modelname
  namespace :api, defaults: { format: :json }, path: '/' do
    
    scope module: :v1 do
      
      resources :consumers, :only => [:index, :show, :create ]
      
    end
  end
  
end
