# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'hops/index'
      post 'hops/create'
      delete 'hops/:id', to: 'hops#destroy'
    end
  end

  resources :hops, only: :index
  resources :beers

  root 'hops#index'
end
