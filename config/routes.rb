Rails.application.routes.draw do
  devise_for :users, controllers: {
	sessions: 'users/sessions',
	registrations: 'users/registrations'
  }
  resources :posts
  resources :users, only: [ :show ] do
	member do
	  get :friends, :requests
	end
  end
  resources :notifications, only: [ :destroy, :index ]
  resources :likes, only: [ :create, :destroy ]
  resources :comments, only: [ :create, :destroy, :update ]
  resources :friendships, only: [ :create, :update, :destroy ]
  root "static_pages#home"
end
