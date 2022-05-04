# frozen_string_literal:true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :invoices do
    resources :line_item_dates, except: %i[index show]
  end
end
