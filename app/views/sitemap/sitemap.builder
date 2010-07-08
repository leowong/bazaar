xml.instruct!
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url
  end
  @pages.each do |page|
    xml.url do
      xml.loc url_for(:controller => :pages, :action => :show, :id => page.slug, :only_path => false)
      xml.lastmod page.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    end
  end
  @stores.each do |store|
    xml.url do
      xml.loc url_for(:controller => :users, :action => :show, :username => store.username, :only_path => false)
      xml.lastmod store.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    end
  end
  @products.each do |product|
    xml.url do
      xml.loc url_for(:controller => :products, :action => :show, :id => product.permalink, :only_path => false)
      xml.lastmod product.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    end
  end
end
