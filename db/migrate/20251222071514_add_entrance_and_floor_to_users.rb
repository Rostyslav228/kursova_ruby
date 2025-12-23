class AddEntranceAndFloorToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :entrance, :string
    add_column :users, :floor, :string
  end
end
