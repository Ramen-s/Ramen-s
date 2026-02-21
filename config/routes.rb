Rails.application.routes.draw do

  # =========================================================
  # devise（顧客 / 管理者）
  # =========================================================
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # =========================================================
  # public（顧客側）
  # =========================================================
  scope module: :public do
    root "homes#top"

    get "about" => "homes#about", as: 'about'

    resources :items, only: [:index, :show]

    # customers（マイページ・編集・退会）
    get   "customers/my_page"          => "customers#show"
    get   "customers/information/edit" => "customers#edit"
    patch "customers/information"      => "customers#update"
    get   "customers/unsubscribe"      => "customers#unsubscribe"
    patch "customers/withdraw"         => "customers#withdraw"

    # cart_items
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    # orders
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post :confirm
        get  :complete
      end
    end

    # addresses
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  # =========================================================
  # admin（管理者側）
  # =========================================================
  namespace :admin do
    get "homes/top"
    root "homes#top"
    
    get 'new/items' => 'items#new', as: 'new_item'
    resources :items, only: [:index,  :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    get '/' => 'homes#top'
  end

end
