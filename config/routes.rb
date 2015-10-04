Rails.application.routes.draw do
  devise_for :users, controllers: {
	sessions: 'users/sessions',
	registrations: 'users/registrations'
  }
  resources :posts
  resources :users, only: [ :show ]
  resources :notifications, only: [ :destroy, :index ]
  resources :friendships, only: [ :create, :update, :destroy ]
  root "static_pages#home"
end
