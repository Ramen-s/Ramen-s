class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new

    if current_customer.cart_items.blank?
      redirect_to cart_items_path, notice: "カートに商品が入っていません。"
    end
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name}  #{current_customer.first_name}"
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end

    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800

    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
  

  def create
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id
  @order.shipping_cost = 800

  if @order.save
    # 1. カートの商品を一つずつ「注文詳細」にコピーする
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.with_tax_price # 購入時の価格を保存
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0 # 製作ステータス初期値
      @order_detail.save
    end
    # 2. カートを空っぽにする
    current_customer.cart_items.destroy_all
    # 3. サンクスページ（complete）へ移動
    redirect_to complete_orders_path
  else
    render :new
  end
end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment)
  end
end
