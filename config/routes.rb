Rails.application.routes.draw do

  post '/get_info', to: 'website_info#show'
  post '/save_info', to: 'website_info#create'

  resources :website_info, only: [:create, :show, :index]
end
