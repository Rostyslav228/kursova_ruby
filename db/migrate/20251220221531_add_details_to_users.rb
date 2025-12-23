class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company, :string
    add_column :users, :vat_number, :string
    add_column :users, :street, :string
    add_column :users, :house_number, :string
    add_column :users, :apartment, :string
    add_column :users, :zip_code, :string
  end
end
