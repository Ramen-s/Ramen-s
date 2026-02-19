class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum :payment_method, { credit_card: 0, bank_transfer: 1 }
  enum :status, {
    waiting_for_payment: 0,   # 入金待ち
    payment_confirmed: 1,     # 入金確認
    making: 2,                # 製作中
    preparing_shipment: 3,    # 発送準備中
    shipped: 4                # 発送済み
  }
end
