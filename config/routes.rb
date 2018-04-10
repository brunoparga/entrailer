Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :film_titles do
    resources :detailed_films, only: %i[new create]
  end
  resources :detailed_films, except: %i[new create]

  resources :formats, only: %i[edit update]
  resources :screens, except: %[update] do
    resources :formats_screens, only: :index
    resources :screenings do
      resources :sold_tickets
    end
  end


end
