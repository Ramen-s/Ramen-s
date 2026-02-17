class Address < ApplicationRecord
  belongs_to :customer
  
  # バリデーション（必須項目）
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  # 宛名選択表示用メソッド（〒000-0000 住所 宛名）
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end