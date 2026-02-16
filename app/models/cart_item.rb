class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :amount, presence: true

  # 小計（税込価格 × 個数）
  def subtotal
    item.with_tax_price * amount
  end
end