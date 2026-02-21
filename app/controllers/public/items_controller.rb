class Public::ItemsController < ApplicationController
  PER_PAGE = 8

  def index
    @genres = Genre.order(:id)
    @selected_genre = Genre.find_by(id: params[:genre_id])

    scope = Item.where(is_active: true).includes(:genre).order(created_at: :desc)
    scope = scope.where(genre_id: @selected_genre.id) if @selected_genre.present?

    # 件数（全件）
    @items_count = scope.count

    # 現在ページ（1以上）
    @page = params[:page].to_i
    @page = 1 if @page < 1

    # 総ページ数
    @total_pages = (@items_count.to_f / PER_PAGE).ceil
    @total_pages = 1 if @total_pages < 1

    # 取得（8件/ページ）
    offset = (@page - 1) * PER_PAGE
    @items = scope.limit(PER_PAGE).offset(offset)
  end

  def show
    @genres = Genre.order(:id)
    @item = Item.where(is_active: true).includes(:genre).find(params[:id])
  end
end