DoortagsRails::Application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :tags

  namespace :api do
    resources :auth, :only => [:create]
    post "auth/invalidate", :to => "auth#destroy"
    resources :tags, :only => [:create]
    get '/tags/(:user_id)', to: 'tags#index'
    put '/tags/update/(:tag_code)/(:location)', to: 'tags#update'
    get '/tags/show_by_code/(:tag_code)', to: 'tags#show_by_code'
    get '/tags/show_by_id/(:id)', to: 'tags#show_by_id'
    delete '/tags/(:tag_code)', to: 'tags#destroy'
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
