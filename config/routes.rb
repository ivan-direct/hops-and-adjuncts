# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :hops
    end
  end

  resources :hops, only: :index
  resources :beers

  root 'hops#index'
end
