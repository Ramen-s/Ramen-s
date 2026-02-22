class Admin::ItemsController < ApplicationController
  # 一時的に管理者ログインを無効化したい場合はコメントアウトのままにする
  # before_action :authenticate_admin!

  before_action :set_item,   only: [:show, :edit, :update]
  before_action :set_genres, only: [:new, :create, :edit, :update]

  def index
    @items = Item.order(:id).page(params[:page]).per(10)
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

  def set_genres
    @genres = Genre.all
  end

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end