class AddBrandSizesAndOldPriceToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :sizes, :string
    add_column :products, :brand, :string
    add_column :products, :old_price, :decimal
  end
end
