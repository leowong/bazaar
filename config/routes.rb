ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.search 'search', :controller => 'search', :action => 'index'
  map.recent 'recent', :controller => 'welcome', :action => 'recent'
  map.toss 'toss', :controller => 'welcome', :action => 'toss'

  map.resources :user_sessions
  map.resources :users, :as => 'stores', :only => [:index, :show]
  map.resources :products, :only => [:index, :show]

  map.namespace :admin do |admin|
    admin.resources :products, :collection => { :sort => :post }
    admin.resources :users, :as => 'stores'
    admin.resources :images, :except => [:index, :show]
  end

  map.root :controller => "welcome"
  map.store ':username', :controller => 'users', :action => 'show'
end
