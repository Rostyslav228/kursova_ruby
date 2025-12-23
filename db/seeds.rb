# Чистимо старі категорії, щоб не було дублікатів
Category.destroy_all

puts "Створюємо категорії..."

# 1. ОДЯГ
clothing = Category.create!(name: "Одяг")
Category.create!(name: "Футболки та Майки", parent: clothing)
Category.create!(name: "Штани та Шорти", parent: clothing)
Category.create!(name: "Куртки та Парки", parent: clothing)
Category.create!(name: "Фліси та Светри", parent: clothing)
Category.create!(name: "Головні убори", parent: clothing)
Category.create!(name: "Рукавиці", parent: clothing)

# 2. ВЗУТТЯ
footwear = Category.create!(name: "Взуття")
Category.create!(name: "Тактичне взуття", parent: footwear)
Category.create!(name: "Трекінгове взуття", parent: footwear)
Category.create!(name: "Кросівки", parent: footwear)
Category.create!(name: "Засоби догляду", parent: footwear)

# 3. РЮКЗАКИ
backpacks = Category.create!(name: "Рюкзаки")
Category.create!(name: "Тактичні рюкзаки", parent: backpacks)
Category.create!(name: "Міські рюкзаки", parent: backpacks)
Category.create!(name: "Сумки та Баули", parent: backpacks)
Category.create!(name: "Підсумки", parent: backpacks)

# 4. ОКУЛЯРИ
glasses = Category.create!(name: "Окуляри")
Category.create!(name: "Балістичні окуляри", parent: glasses)
Category.create!(name: "Сонцезахисні", parent: glasses)
Category.create!(name: "Аксесуари", parent: glasses)

# 5. ПАТЧІ
patches = Category.create!(name: "Патчі/Шеврони")
Category.create!(name: "PVC (Гумові)", parent: patches)
Category.create!(name: "Вишиті", parent: patches)
Category.create!(name: "Прапори", parent: patches)

puts "Готово! Категорії створено."