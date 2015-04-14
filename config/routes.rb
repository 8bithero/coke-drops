Rails.application.routes.draw do

  resources :tweets do
    delete 'reset', on: :collection
  end
  
  root 'tweets#index'

end
