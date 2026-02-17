class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.order(:id)
    @selected_genre = Genre.find_by(id: params[:genre_id])

    scope = Item.where(is_active: true).includes(:genre).order(created_at: :desc)
    scope = scope.where(genre_id: @selected_genre.id) if @selected_genre.present?

    @items = scope
    @items_count = scope.count
  end

  def show
    @genres = Genre.order(:id)
    @item = Item.where(is_active: true).includes(:genre).find(params[:id])
  end
end
