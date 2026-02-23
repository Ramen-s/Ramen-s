class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    render :orders
  end
  
  # ステータス更新用のアクション（あとで中身を作ります）
  def update
    @order = Order.find(params[:id])
  if @order.update(order_params)
    flash[:notice] = "注文ステータスを更新しました"
    redirect_to admin_order_path(@order)
  else
    render :orders
  end
end

  private

  def order_params
  params.require(:order).permit(:status)
  end
end