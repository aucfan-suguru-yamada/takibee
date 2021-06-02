Rails.application.routes.draw do
  get 'every_camp/index'
  get 'areas/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  root 'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  resources :users, only: %i[new create show edit update] do
    resources :every_camp, only: %i[index] do
      resources :likes, only: [:create, :destroy]
    end
  end
  resources :items, only: %i[index new create destroy]
  resources :user_items, only: %i[index create destroy]
  resources :search_user_items, only: %i[index]
  resources :makers, only: %i[index new create update destroy]
  resources :camps, only: %i[index new create show update destroy] do
    resources :camp_items, only: %i[index new create show destroy]
    get 'search_items', to: 'camp_items#search_items'
    get 'my_items', to: 'camp_items#my_items'
    post 'add_my_items', to: 'camp_items#add_my_items'
    resources :areas, only: %i[index create destroy]
  end
end
