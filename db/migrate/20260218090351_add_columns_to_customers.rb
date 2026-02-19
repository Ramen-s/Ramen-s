class AddColumnsToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :address, :string
  end
end