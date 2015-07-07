Rails.application.routes.draw do



  root to: "posts#index"


  resources :posts do
  		resources :comments
	end

  devise_for :users


end
