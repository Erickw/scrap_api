require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  post '/get_info', to: 'website_info#show'
  post '/save_info', to: 'website_info#create'

  resources :website_info, only: [:create, :show, :index]
end
