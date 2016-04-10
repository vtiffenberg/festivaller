Rails.application.routes.draw do

  resources :passes, except: :show
  resources :discounts, only: [:new, :create, :destroy]

  resources :events, except: :show do
    member do
      post :arrival_count
    end
  end

  resources :registrants, only: [:index, :edit, :update] do
    collection do
      get :upload
      post :bulk_create
    end
    member do
      post :sign_in
    end
  end

  get 'attendance', to: 'attendance#index'
  get 'attendance/:id', to: 'attendance#event'

  get 'settings', to: 'application#settings'

  # You can have the root of your site routed with "root"
  root 'events#index'

end
