Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :posts
  resources :notifications, only: [ :destroy, :index ]
  root "static_pages#home"
end
