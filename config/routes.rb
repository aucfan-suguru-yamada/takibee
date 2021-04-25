Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'static_pages#top'
  resources :users, only: %i[new create]
  resources :items, only: %i[index new create destroy]
  resources :user_items, only: %i[index show create destroy]
  resources :serch_user_items, only: %i[index]
  resources :makers, only: %i[index new create update destroy]
  get 'makers/api', to: 'makers#api'
end
