class RemoveKanaAndAddNameKanaToCustomers < ActiveRecord::Migration[8.0]
  def change
    # 古い kana カラムを削除する
    remove_column :customers, :kana, :string
    
    # 新しい2つのカラムを追加する
    add_column :customers, :last_name_kana, :string
    add_column :customers, :first_name_kana, :string
  end
end
