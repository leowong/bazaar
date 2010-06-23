# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ordering_options
    [
      [t('search.pageviews_high_to_low'), 'pvd'],
      [t('search.price_low_to_high'), 'pa'],
      [t('search.price_high_to_low'), 'pd']
    ]
  end

  # OPTIMIZE: It works, but ugly! Definitely there's a better way.
  def reset_ordering_parameter
    uri = request.request_uri
    uri = uri.gsub(/page=[0-9]*/, '')
    if uri.index("order=")
      uri = uri.sub(/&?order=\w*/, '')
    end
    if uri.index("?")
      uri += "&order="
    else
      uri += "?order="
    end
    uri = uri.sub('?&', '?')
  end

  def cloudfront(url)
    url.gsub(/https?:\/\/s3.amazonaws.com\/bazaar-\w+/, "http://" +  ENV['CLOUDFRONT_SERVER']) if ENV['CLOUDFRONT_SERVER']
    url
  end


  def new_store
    User.new_store
  end
end
