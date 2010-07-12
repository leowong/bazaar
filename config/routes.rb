ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.search 'search', :controller => 'search', :action => 'index'
  map.recent 'recent', :controller => 'welcome', :action => 'recent'
  map.toss 'toss', :controller => 'welcome', :action => 'toss'

  map.connect "sitemap.xml", :controller => "sitemap", :action => "sitemap"

  map.with_options :controller => 'pages' do |page|
    page.about 'about', :action => 'show', :id => 'about'
  end

  map.resources :user_sessions
  map.resources :users, :as => 'stores', :only => [:index, :show]
  map.resources :products, :only => [:index, :show]
  map.resources :pages, :only => :show

  map.namespace :admin do |admin|
    admin.resources :products, :collection => { :sort => :post }
    admin.resources :users, :as => 'stores', :collection => { :sort => :post }
    admin.resources :images, :except => [:index, :show]
    admin.resources :pages
    admin.resources :categories
  end

  map.root :controller => "welcome"
  map.store ':username', :controller => 'users', :action => 'show'
end
