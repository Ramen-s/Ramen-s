class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum production_status: {
    waiting: 0,   # 製作待ち
    making: 1,    # 製作中
    done: 2       # 発送済み（※シート表記に合わせる）
  }
end
