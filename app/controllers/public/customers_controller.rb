class Public::CustomersController < ApplicationController
  # サインアップ（new, create）はログイン前に行うため
  #allow_unauthenticated_access only: [:new, :create]

  #before_action :set_user, only: [:show]

  def show
    @customer = current_customer || Customer.first || Customer.new(name: "testuser", email: "test@example.com")   # 左（顧客）
    #@customer.kana
    #@customer.postal_code
    #@customer.address
    #@customer.telephone_number
    #@customer.email
  end

  def edit; end
  def update; end
  def unsubscribe; end
  def withdraw; end

end