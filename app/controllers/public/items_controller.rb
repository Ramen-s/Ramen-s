class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).order(created_at: :desc)
  end

  def show
    @item = Item.where(is_active: true).find(params[:id])
  end
end
