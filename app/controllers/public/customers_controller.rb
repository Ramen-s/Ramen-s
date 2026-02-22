class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer, only: [:show, :edit, :update, :withdraw]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def unsubscribe
    # 退会確認画面表示
  end

  def withdraw
    @customer.update!(is_active: false)  # ← customer じゃなく @customer
    sign_out current_customer
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(
      :name, :last_name, :first_name, :last_name_kana, :first_name_kana,
      :postal_code, :address, :telephone_number, :email
    )
  end
end