DoortagsRails::Application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :tags

  namespace :api do
    resources :auth, :only => [:create]
    post "auth/invalidate", :to => "auth#destroy"
    resources :tags
    get '/tags(:user_id)', to: 'tags#index'
    post '/message', to: "messages#send_message_to"
  end


  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  get '/', to: 'static_pages#home'
  root to: 'static_pages#home'
end
