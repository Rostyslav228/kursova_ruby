class AddMissingFieldsToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :city, :string
    add_column :orders, :address, :string
    add_column :orders, :shipping_method, :string
    add_column :orders, :payment_method, :string
  end
end