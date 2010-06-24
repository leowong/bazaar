class Image < Asset
  has_attached_file :attachment, 
                    :storage => ENV['S3_BUCKET'] ? :s3 : :filesystem,
                    :bucket => ENV['S3_BUCKET'],
                    :styles => { :mini => '48x48#', :small => '100x100#', :product => '240x240#', :original => '600x600#' }, 
                    :default_style => :product,
                    :url => ENV['S3_BUCKET'] ? "assets/products/:id/:style/:basename.:extension" : "/assets/products/:id/:style/:basename.:extension",
                    :path => ENV['S3_BUCKET'] ? "assets/products/:id/:style/:basename.:extension" : ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                    :s3_credentials => { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'] }

  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 5.megabytes
  validates_attachment_content_type :attachment, :content_type => ['image/gif', 'image/jpeg', 'image/png']

  before_post_process :randomize_image_file_name

  protected

  def randomize_image_file_name
    extension = File.extname(attachment_file_name).downcase
    self.attachment.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex.first(8)}#{extension}")
  end
end
