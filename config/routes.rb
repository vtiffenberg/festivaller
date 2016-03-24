Rails.application.routes.draw do

  resources :events, except: :show
  resources :passes, except: :show
  resources :discounts, only: [:new, :create, :destroy]

  resources :registrants, only: [:index] do
    collection do
      get :upload
      post :bulk_create
    end
  end

  # You can have the root of your site routed with "root"
  root 'events#index'

end
