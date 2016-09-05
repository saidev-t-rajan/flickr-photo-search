Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :photos, only: :index do
    collection do
      get 'search'
    end
  end

  root 'photos#index'
end
