Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only:[:create, :new, :edit, :update, :index, :show]

  resource :session, only:[:new, :create, :destroy]

  resources :subs, except:[:destroy] 
  resources :posts, except:[:destroy, :index]

end
