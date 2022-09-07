Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  resources :users
  resources :sessions
end
