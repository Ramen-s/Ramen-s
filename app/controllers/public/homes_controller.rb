class Public::HomesController < ApplicationController
  def top
    # ジャンルを取得（サイドバー用）
    @genres = Genre.all

    # 販売中の商品を、新しい順に4件取得（新着商品用）
    @new_items = Item.where(is_active: true).order(created_at: :desc).limit(4)
  end

  def about
  end
end

