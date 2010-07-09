task :cron => :environment do
  # [1] Requesting google to update sitemap.xml
  if true
    puts ""
    puts ">>> [#{Time.now.httpdate}] Resubmitting Google Sitemap by sending an HTTP ping request..."
    sitemap_url = 'http://xuncheng.net/sitemap.xml'
    Net::HTTP.get('www.google.com', '/ping?sitemap=' + URI.escape(sitemap_url))
    puts "<<< [#{Time.now.httpdate}] Done."
  end

  # [2] Trimming unused tags
  if true
    puts ""
    puts ">>> [#{Time.now.httpdate}] Trimming unused tags..."
    Tag.all.each do |t|
      if t.products.size == 0
        t.destroy
      end
    end
    puts "<<< [#{Time.now.httpdate}] Done."
  end
end
