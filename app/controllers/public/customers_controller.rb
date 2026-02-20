class Public::CustomersController < ApplicationController

  # サインアップ（new, create）はログイン前に行うため
  #allow_unauthenticated_access only: [:new, :create]

  #before_action :set_user, only: [:show]

  def show
    @customer = current_customer || Customer.first || Customer.new(name: "testuser", email: "test@example.com")   # 左（顧客）
    @customer.kana
    @customer.postal_code
    @customer.address
    @customer.telephone_number
    @customer.email

    #mainでこれに変更！！！！
    #@customer  = Current.session.user   # 左（顧客）

  end

  def edit
    #ログイン未実装
    @customer = Customer.first  || Customer.new(name: "testuser", email: "test@example.com")
    #本番環境では下記
    #@customer = current_customer
  end

  def update
    #ログイン未実装
    @customer = Customer.first
    #本番環境では下記
    #@customer = current_customer

    if @customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def unsubscribe
  end

  def withdraw_confirm
    #ログイン未実装
    @customer = Customer.first
    #本番環境では下記
    #@customer = current_customer
  end

  def withdraw
    @customer = Customer.first
    #本番環境では下記
    #@customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(
      :name, :last_name, :first_name, :kana,
      :postal_code, :address, :telephone_number, :email
    )
  end

end
