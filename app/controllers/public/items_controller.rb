class Public::ItemsController < ApplicationController
  PER_PAGE = 8

  def index
    @genres = Genre.order(:id)
    @selected_genre = Genre.find_by(id: params[:genre_id])

    scope = Item.where(is_active: true).includes(:genre).order(created_at: :desc)
    scope = scope.where(genre_id: @selected_genre.id) if @selected_genre.present?

    # kaminariでページング
    @items = scope.page(params[:page]).per(PER_PAGE)

    # 全件数が必要なら（kaminari後でもOK）
    @items_count = scope.count
  end

  def show
    @genres = Genre.order(:id)
    @item = Item.where(is_active: true).includes(:genre).find(params[:id])
  end
end