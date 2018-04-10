Rails.application.routes.draw do
  get 'sold_tickets/index'

  get 'sold_tickets/show'

  get 'sold_tickets/new'

  get 'screenings/index'

  get 'screenings/show'

  get 'screenings/new'

  get 'screenings/create'

  get 'screenings/destroy'

  get 'screens/index'

  get 'screens/show'

  get 'formats_screens/index'

  get 'formats_screens/new'

  get 'formats_screens/create'

  get 'formats_screens/update'

  get 'formats/edit'

  get 'formats/update'

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
