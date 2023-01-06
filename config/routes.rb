Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions:'public/sessions'
  }

    namespace :public do

      resources :items, only: [:index, :show]
      resources :registrations, only: [:new, :create]
      resources :sessions, only: [:new, :create, :destroy]
      resources :customers, only: [:show, :edit, :update] do
        collection do
          get '/customers/confirmation' => 'customers#confirmation'
          patch 'withdrawal'
        end
      end
      resources :cart_items, only: [:index, :update, :create, :destroy] do
        collection do
          delete 'destroy_all'
        end
      end
      resources :orders, only: [:new, :create, :index, :show] do
        collection do
          post 'customers/order' => 'orders#confirmation'
          get 'customers/order' => 'orders#completed'
        end
      end
      resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    end

    get '/customer' => 'customer/homes#top'


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"}

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    resources :items
    resources :genres, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders,  only: [:show, :update]
    resources :order_details, only: [:update]
  end
  root to: 'public/homes#top'
  get '/admin' => 'admin/homes#top'
  get 'home/about' => 'public/homes#about', as: 'about'
  end