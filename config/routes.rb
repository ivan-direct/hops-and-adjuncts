# frozen_string_literal: true

Rails.application.routes.draw do
  root 'hops#index'

  namespace :api do
    namespace :v1 do
      resources :hops do
        collection do
          get :featured
          get :popular
        end
      end

      resources :adjuncts do
        collection do
          get :featured
          get :popular
        end
      end
    end
  end

  # this will prevent browser redirects from breaking the React Router flow
  get '*path', to: 'hops#index'
end
