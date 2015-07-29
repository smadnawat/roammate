Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "profiles#home"
  get 'profile_status/:id' => "profiles#profile_status" ,:as => "profile_status"
  delete 'bad_rate/:id' => "messages#delete_bad_rating",:as => "delete_bad_rateing"

  delete 'destroy_users/:id' => "users#destroy_users" , :as => "destroy_users"
  get 'post/:post_id/delete_comment/:id' => "comments#delete_comment",:as => "delete_comment"
  post 'upload_file' => "upload_files#upload_file"

  #*****************************************************************************
   post 'signin' => "users#login"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'predefined_interests' => 'interests#predefined_interests'
  get 'predefined_events' => 'events#predefined_events'
  post 'selected_interest_list' => 'interests#selected_interest_list'
  post 'find_mutual_interest' => 'interests#find_mutual_interest'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  match "*path", to: "users#catch_404", via: :all
end
