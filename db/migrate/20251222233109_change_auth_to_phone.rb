class ChangeAuthToPhone < ActiveRecord::Migration[7.1]
  def change
    # 1. Робимо email необов'язковим (дозволяємо NULL)
    change_column_null :users, :email, true

    # 2. Видаляємо унікальний індекс з email (бо тепер багато людей можуть бути без пошти, тобто мати NULL)
    remove_index :users, :email

    # 3. Додаємо звичайний індекс для email (для швидкості, якщо хтось таки шукатиме)
    add_index :users, :email

    # 4. Робимо телефон унікальним (це тепер логін)
    # Переконайтеся, що у вас в базі немає дублікатів телефонів перед запуском!
    add_index :users, :phone, unique: true
  end
end