Rails.application.routes.draw do
  root :to => "movies#index", :director_id => '1'

  resources :directors, shallow: true, only: [:index, :show] do
    resources :movies, only: [:index, :show]
  end
end
