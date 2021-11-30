# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :hops do
        collection do
          get :featured
          get :popular
        end
      end
    end
  end

  resources :hops, only: :index

  root 'hops#index'
  match '*', to: 'hops#index', via: :all, constraints: {subdomain: /.+\.hops/}
end
