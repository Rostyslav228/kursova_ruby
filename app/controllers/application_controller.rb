class ApplicationController < ActionController::Base
  # 1. Підключаємо модуль кошика та встановлюємо його перед діями
  include CurrentCart
  before_action :set_cart

  # 2. Вмикаємо перевірку дозволених параметрів для Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Список усіх полів, які ми дозволяємо передавати у формах
    keys = [
      :phone, :phone_number, :email,          # Контакти (phone - головний)
      :first_name, :last_name,                # Ім'я
      :country, :city, :address,              # Загальна адреса
      :company, :vat_number,                  # Бізнес
      :street, :house_number, :apartment, :zip_code, :entrance, :floor # Деталі адреси
    ]

    # Дозволяємо ці поля при реєстрації (Sign Up)
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)

    # Дозволяємо ці поля при редагуванні профілю (Account Update)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
    
    # ВАЖЛИВО: Для входу дозволяємо саме :phone
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone])
  end
end