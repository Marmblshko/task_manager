Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :projects

  resources :tasks do
    resources :reports, except: [:index, :show]
  end
end
