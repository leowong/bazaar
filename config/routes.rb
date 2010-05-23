ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.admin 'admin', :controller => 'admin/users', :action => 'show'
  map.search 'search', :controller => 'search', :action => 'index'

  map.resources :user_sessions
  map.resources :users, :as => 'stores', :only => [:index, :show]
  map.resources :products, :only => [:index, :show]

  map.namespace :admin do |admin|
    admin.resources :products
    admin.resources :users, :as => 'stores'
    admin.resources :images, :except => [:index, :show]
  end

  map.root :controller => "welcome"
  map.store ':username', :controller => 'users', :action => 'show'
end
