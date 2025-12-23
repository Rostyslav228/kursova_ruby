class RemoveOldCategoryColumnFromProducts < ActiveRecord::Migration[8.1]
  def change
    # Видаляємо стару текстову колонку 'category'
    remove_column :products, :category, :string
  end
end