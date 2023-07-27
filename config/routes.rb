# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => 'admin/sidekiq'

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
    resources :posters
    root to: 'pages#home'
  end
end
