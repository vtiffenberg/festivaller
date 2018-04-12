Rails.application.routes.draw do

  devise_for :users, skip: [:registrations]#, controllers: { registrations: :registrations }
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  resources :passes, except: :show
  resources :seasons, except: :show do
    member do
      post :set_current
    end
  end

  resources :events, except: :show do
    member do
      post :arrival_count
      post :registered_count
      post :attendee_count
      get :venue_payment
    end
  end

  resources :registrants, only: [:index, :edit, :update] do
    collection do
      get :upload
      post :bulk_create
      get :empty_pass
    end
    member do
      post :sign_in
      post :pay
    end
  end

  get 'attendance', to: 'attendance#index'
  get 'attendance/:id', to: 'attendance#event', as: 'event_attendance'

  get 'settings', to: 'application#settings'

  # You can have the root of your site routed with "root"
  root 'events#index'

end
