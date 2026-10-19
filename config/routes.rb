Rails.application.routes.draw do

  # 顧客用
  root to: "public/homes#top"
  get  "/about", to: "public/homes#about"
  get  "/signup", to: "public/registrations#new"
  post "/signup", to: "public/registrations#create"

  scope module: :public do
    resource :session, only: [:new, :create, :destroy]
    resources :passwords, param: :token
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :admin do
    # 管理者ログイン・ログアウト
    resource :session, only: [:new, :create, :destroy]

    # 管理者トップ
    get "/", to: "homes#top", as: :top

    # 管理者の顧客一覧
    resources :customers, only: [:index, :show]
  end
end
