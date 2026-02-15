Rails.application.routes.draw do
  # =========================================================
  # devise（顧客/管理者）
  # ※ controller名はチームの実装に合わせて後で変更OK
  # =========================================================
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # =========================================================
  # public（顧客側）
  # =========================================================
  scope module: :public do
    #root "homes#top"
    root "addresses#index"
    get "about" => "homes#about"

    resources :items, only: [:index, :show]

    # customers（マイページ・編集・退会）
    get  "customers/my_page"            => "customers#show"
    get  "customers/information/edit"   => "customers#edit"
    patch "customers/information"       => "customers#update"
    get  "customers/unsubscribe"        => "customers#unsubscribe"
    patch "customers/withdraw"          => "customers#withdraw"

    # cart_items
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    # orders（confirm / thanks を独自アクション）
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post :confirm     # ここはPOST推奨（フォーム内容を送って確認画面へ）
        get  :thanks
      end
    end

    # addresses（配送先）
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  # =========================================================
  # admin（管理者側）
  # =========================================================
  namespace :admin do
    get "/" => "homes#top"

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
