Rails.application.routes.draw do

  root to: 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  # get 'sessions/new'
  # get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # delete :logout, to: 'sessions#destroy'

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  resources :feedbacks, only: %i[new create]

  namespace :admin do
    resources :tests, shallow: true do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :gists, only: :index
  end
end
