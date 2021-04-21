Rails.application.routes.draw do
  get 'user_items/index'
  get 'items/serch'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'static_pages#top'
  resources :users, only: %i[new create]
  resources :items, only: %i[index new create]
  resources :user_items, only: %i[index show create]
  resources :serch_user_items, only: %i[index]
end
