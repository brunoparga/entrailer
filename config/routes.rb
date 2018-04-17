Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :owners, only: %i[new create show]

  resources :film_titles, only: %i[index new create] do
    resources :detailed_films, only: %i[new create]
  end
  resources :detailed_films, only: %i[index show]

  resources :formats, only: %i[edit update]
  resources :screens do
    resources :formats_screens, only: :index
  end

  resources :screenings do
    resources :tickets, only: :create
  end

  resources :tickets, only: %i[show index] do
    resources :payments, only: %i[new create]
  end
  resources :search, only: :index
end
