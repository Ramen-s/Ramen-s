class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # どの顧客の注文か（外部キー）
      t.integer :customer_id,    null: false
      # お届け先情報
      t.string  :postal_code,    null: false
      t.string  :address,        null: false
      t.string  :name,           null: false
      # 金額情報
      t.integer :shipping_cost,  null: false
      t.integer :total_payment,  null: false
      # ステータス（enum用）
      t.integer :payment_method, null: false, default: 0
      t.integer :status,         null: false, default: 0

      t.timestamps
    end
  end
endorder