xml.instruct!
xml.urlset :'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", :'xsi:schemaLocation' => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd", :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc root_url
    xml.lastmod @hottest_product.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq "daily"
    xml.priority "1.0"
  end
  xml.url do
    xml.loc recent_url
    xml.lastmod @products.first.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq "daily"
    xml.priority "1.0"
  end
  xml.url do
    xml.loc products_url
    xml.lastmod @hottest_product.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq "daily"
    xml.priority "0.8"
  end
  xml.url do
    xml.loc users_url
    xml.lastmod @stores.first.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq "weekly"
    xml.priority "0.8"
  end
  @products.each do |product|
    xml.url do
      xml.loc url_for(:controller => :products, :action => :show, :id => product.permalink, :only_path => false)
      xml.lastmod product.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq "daily"
      xml.priority "0.8"
    end
  end
  @stores.each do |store|
    xml.url do
      xml.loc url_for(:controller => :users, :action => :show, :username => store.username, :only_path => false)
      xml.lastmod store.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq "weekly"
      xml.priority "0.8"
    end
  end
  @pages.each do |page|
    xml.url do
      xml.loc url_for(:controller => :pages, :action => :show, :id => page.slug, :only_path => false)
      xml.lastmod page.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq "weekly"
      xml.priority "0.6"
    end
  end
end
