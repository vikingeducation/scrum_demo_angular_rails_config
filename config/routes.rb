Rails.application.routes.draw do

  devise_for :users
  scope :api do
    scope :v1 do
      resources :messages, :only => [:index, :create, :destroy]
    end
  end
  root 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
