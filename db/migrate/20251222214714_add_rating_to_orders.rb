class AddRatingToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :rating, :integer
    add_column :orders, :review, :text
  end
end
