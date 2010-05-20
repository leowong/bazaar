class Image < Asset
  has_attached_file :attachment, 
                    :storage => ENV['S3_BUCKET'] ? :s3 : :filesystem,
                    :bucket => ENV['S3_BUCKET'],
                    :styles => { :mini => '48x48#', :small => '100x100#', :product => '240x240#', :original => '600x600#' }, 
                    :default_style => :product,
                    :url => ENV['S3_BUCKET'] ? "assets/products/:id/:style/:basename.:extension" : "/assets/products/:id/:style/:basename.:extension",
                    :path => ENV['S3_BUCKET'] ? "assets/products/:id/:style/:basename.:extension" : ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                    :s3_credentials => { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'] },
                    :s3_permissions => 'public-read'

  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 5.megabytes
  validates_attachment_content_type :attachment, :content_type => ['image/gif', 'image/jpeg', 'image/png']

  S3 = 'http://s3.amazonaws.com'
  DISTRIBUTION = 'http://d1llmx3bs1dc42.cloudfront.net'

  def cloudfront_url( variant = nil )
    if ENV['S3_BUCKET']
      self.attachment.url(variant).gsub( "#{S3}/#{ENV[S3_BUCKET]}", DISTRIBUTION )
    else
      self.attachment.url(variant)
    end
  end
end
