class Photo
  attr_reader :id, :secret, :server, :farm

  def initialize( attributes = {} )
    @id      = attributes['id']
    @secret  = attributes['secret']
    @server  = attributes['server']
    @farm    = attributes['farm']
  end


  # Refer https://www.flickr.com/services/api/misc.urls.html for url generation

  def url_small
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_q.jpg"
  end

  def url_large
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_c.jpg"
  end
end
