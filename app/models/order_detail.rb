class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum :making_status, {
    waiting: 0,   # 製作待ち
    making: 1,    # 製作中
    done: 2       # 製作完了
  }
end
