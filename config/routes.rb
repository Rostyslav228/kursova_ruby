Rails.application.routes.draw do
  # Головна сторінка
  root "pages#home"
  
  # Користувачі (Devise)
  devise_for :users

  # Товари та Лайки
  resources :products do
    resource :favorites, only: [:create, :destroy]
  end

  # Кошик
  resource :cart, only: [:show, :destroy]
  
  # Елементи кошика (create - додати, update - змінити кількість, destroy - видалити)
  resources :cart_items, only: [:create, :update, :destroy]
  resources :reviews, only: [:create]
  # Замовлення + ВІДГУКИ
resources :orders, only: [:new, :create, :update, :show, :edit] do
    member do
      patch :add_review
    end
  end
  
  # Особистий кабінет
  get 'dashboard', to: 'dashboard#index'
  
  # Перевірка здоров'я додатка
  get "up" => "rails/health#show", as: :rails_health_check
end