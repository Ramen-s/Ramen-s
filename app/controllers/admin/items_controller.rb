class Admin::ItemsController < ApplicationController
  # TODO: 管理者認証（devise）を入れているなら後で有効化
  # before_action :authenticate_admin!

  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
  end
end
