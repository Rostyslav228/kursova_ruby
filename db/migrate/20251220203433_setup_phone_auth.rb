class SetupPhoneAuth < ActiveRecord::Migration[8.0] # Перевірте версію в дужках, може бути [7.1] або [7.0]
  def change
    # Додаємо колонку для телефону
    add_column :users, :phone_number, :string
    add_index :users, :phone_number, unique: true

    # Дозволяємо пусту пошту (email тепер не обов'язковий)
    change_column_null :users, :email, true
  end
end