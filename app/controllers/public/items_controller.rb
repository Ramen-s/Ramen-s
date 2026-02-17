class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.order(:id)

    scope = Item.where(is_active: true).includes(:genre).order(created_at: :desc)
    scope = scope.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    @items = scope
  end

  def show
    @genres = Genre.order(:id)
    @item = Item.where(is_active: true).includes(:genre).find(params[:id])
  end
end
