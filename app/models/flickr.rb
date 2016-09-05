class Flickr
  attr_accessor :error, :uri

	def search( free_text )
    # Refer https://www.flickr.com/services/api/flickr.photos.search.html for uri generation
    @uri = URI(URI.encode("https://api.flickr.com/services/rest/?api_key=#{FLICKR_API_KEY}&method=flickr.photos.search&text=#{free_text}"))

    if response_hash
      if response_hash['rsp']['stat'] == 'ok'
        if response_hash['rsp']['photos']['photo']
          return response_hash['rsp']['photos']['photo'].map{ |photo| Photo.new(photo) }
        else
          self.error = "There are no photos that match your search"
        end
      elsif response_hash['rsp']['stat'] == 'fail'
        self.error = response_hash['rsp']['err']['msg']
      end
    else
      self.error = "Something went wrong, please try again"
    end
    []
  end

  def response_hash
    Hash.from_xml( Net::HTTP.get(uri) )
  end
end
