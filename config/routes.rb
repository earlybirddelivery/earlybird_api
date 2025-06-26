require 'rack/session/cookie'
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :crm_customer_mappings
  resources :dealers
  resources :reference_data
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '*other', to: 'home#index'
  api_version(module: 'V1', header: { name: 'Accept', value: 'application/vnd.earlybird.com; version=1' }) do
    devise_scope :user do
      # resources :otps do
      #   post :send_otp, on: :collection
      # end
    end
    resources :referrals, only: %i[create] do
      get :referred_count, on: :collection
    end
    resources :users, only: [] do
      put :send_verification_otp, on: :collection
      get :dashboard, on: :collection 
      resources :user_favourite_products, only: %i[create index] do
        delete :remove_from_favourites, on: :collection
      end
      resources :fcm_registration_ids, only: :create
    end
    resources :manual_notifications do
      post :publish_notification, on: :member
    end
    resources :carts, only: [] do
      resources :cart_items
    end
    resources :delivery_tasks
    resources :address_details
    resources :delivery_boys
    resources :orders do
      get :payment_confirmation, on: :member
      put :generate_razor_pay_order_id, on: :member
      put :place_order, on: :member
      put :out_for_delivery, on: :member
      put :delivered, on: :member
      put :cancel, on: :member
      put :raise_issue, on: :member
      resources :order_items, only: [] do
        put :pause_subscription, on: :member
        put :resume_subscription, on: :member
      end
    end
    resources :posters, only: %i[update index]
    resources :products do
      get :explore, on: :collection
    end
    resources :brands
    resources :customers do
      post :sign_up, on: :collection
      collection do
        get :search
      end
    end

    namespace :delivery_boy_order do
      resources :orders, only: [:update]
    end
  end

  # Move Sidekiq web UI routes BEFORE any catch-all routes
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  Sidekiq::Web.use Rack::Session::Cookie, key: '_early_bird_sidekiq_session',
                                          secret: Rails.application.credentials[:secret_key_base]
  unless Rails.env.development?
    Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                  ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])
                                                 ) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                    ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD'])
                                                   )
    end
  end

  # Catch-all routes should be LAST
  match '*path', to: 'application#common_response', via: %i[get post]
  get '*other', to: 'home#index'
end
