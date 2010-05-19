# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ordering_options
    [['Price: low to high', 'pa'], ['Price: high to low', 'pd']]
  end

  def reset_ordering_parameter
    uri = request.request_uri
    if uri.index("order=")
      uri = uri.sub(/&?order=\w*/, '')
    end
    if uri.index("?")
      uri += "&order="
    else
      uri += "?order="
    end
    uri.sub('?&', '?')
  end
end
