Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "profiles#home"
  get 'profile_status/:id' => "profiles#profile_status" ,:as => "profile_status"
  get 'message_status/:id' => "messages#message_status" ,:as => "message_status"
  get 'special_message_status/:id' => "messages#special_message_status" ,:as => "special_message_status"
  delete 'bad_rate/:id' => "messages#delete_bad_rating",:as => "delete_bad_rateing"

  delete 'destroy_users/:id' => "users#destroy_users" , :as => "destroy_users"
  get 'post/:post_id/delete_comment/:id' => "comments#delete_comment",:as => "delete_comment"
  post 'upload_file' => "upload_files#upload_file"

  #*****************************************************************************

  post 'signin' => "users#login"
  post 'add_current_city' => "cities#add_current_city"
  post 'match_users' => "users#match_users"
  post 'point_algo' => "points#point_algo"
  post 'picked_interest_user_list' => "interests#picked_interest_user_list"
  post 'create_new_message' => "messages#create_new_message"
  post 'get_messages' => "messages#get_messages"
  post 'new_user_rating' => "ratings#new_user_rating"
  post 'update_user_rating' => "ratings#update_user_rating"
  post 'add_profile_picture' => "profiles#add_profile_picture"
  post 'create_post' => "posts#create_post"
  post 'create_comment' => "comments#create_comment"
  post 'get_comments' => "comments#get_comments"
  post 'update_profile' => "profiles#update_profile"
  
  get 'get_settings' => "notifications#get_settings"
  get 'get_gender' => "notifications#get_gender"
  get 'my_notifications' => "notifications#my_notifications"
  get 'my_profile' => "profiles#my_profile"
  get 'get_roammate_to_add_in_group' => "invitations#get_roammate_to_add_in_group"
  get 'special_messages' => "messages#special_messages"
  get 'add_member_to_group' => "invitations#add_member_to_group"
  get 'delete_message' => "messages#delete_message"
  get 'user_inbox' => "messages#user_inbox"
  post 'accept_or_decline_invitation' => "invitations#accept_or_decline_invitation"
  get 'view_matched_profile' => "profiles#view_matched_profile"
  get 'add_member_as_roammate' => "invitations#add_member_as_roammate"
  post '/settings' => "notifications#settings"
  post '/gender_update' => "notifications#gender_update"
  post '/pre_selected_interests' => "interests#pre_selected_interests"
  get '/get_posts' => "posts#get_posts"
  # get 'get_point' =>"points#get_point"
  # get 'get_profile' => "profiles#get_profile"
  get 'get_user_cities' => "cities#get_user_cities"
  get 'remove_city' => "cities#remove_city"
  # get 'get_interests' => "interests#get_interests"
  # get 'select_user_to_add' => 'invitations#select_user_to_add'
  # get 'select_user_to_add' => 'interests#select_user_to_add'
  post 'predefined_interests' => 'interests#predefined_interests'
  get 'get_predefined_events' => 'events#get_predefined_events'
  # post 'filter_user_selected_interest' => 'interests#filter_user_selected_interest'
  post 'signin' => "users#login"
  post 'selected_interest_list' => 'interests#selected_interest_list'
  # post 'find_mutual_interest' => 'interests#find_mutual_interest'
  get 'offline' => 'users#offline'
  match "*path", to: "users#catch_404", via: :all
end
