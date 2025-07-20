Rails.application.routes.draw do
  # ホーム画面
  root "home#index"

  # 家族（ネストしてメンバー追加）
  resources :families, only: [:new, :create, :show] do
    resources :members, only: [:new, :create]
  end

  # 家族コードログイン
  resource :family_login, only: [:new, :create]
  delete "/family_logout", to: "family_logins#destroy", as: :family_logout

  get 'join/:code', to: 'families#join', as: :join_family

  resources :families do
  member do
    patch :regenerate_family_code
  end
end

  # レシピ
  resources :recipes do
  member do
    get :public_view
  end

  collection do
    get :public_index
  end
end


  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA対応
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end