class Customer < ApplicationRecord
  # devise を使う前提（入れてるmoduleはチームのdevise設定に合わせて調整）
  # devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
