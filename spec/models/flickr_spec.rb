require 'rails_helper'

describe Flickr do
  response_hash = {"rsp"=>{ "stat"=>"ok",
                            "photos"=>{ "page"=>"1",
                                        "pages"=>"240680",
                                        "perpage"=>"100",
                                        "total"=>"24067966",
                                        "photo"=>[{ "id"=>"1",
                                                    "owner"=>"2",
                                                    "secret"=>"3",
                                                    "server"=>"4",
                                                    "farm"=>"5",
                                                    "title"=>"First Photo",
                                                    "ispublic"=>"1",
                                                    "isfriend"=>"0",
                                                    "isfamily"=>"0"},
                                                  { "id"=>"2",
                                                    "owner"=>"3",
                                                    "secret"=>"4",
                                                    "server"=>"5",
                                                    "farm"=>"6",
                                                    "title"=>"Second Photo",
                                                    "ispublic"=>"1",
                                                    "isfriend"=>"0",
                                                    "isfamily"=>"0"}]}}}

  response_hash_no_photos = {"rsp"=>{"stat"=>"ok", "photos"=>{"page"=>"1", "pages"=>"0", "perpage"=>"100", "total"=>"0"}}}

  response_hash_fail = {"rsp"=>{"stat"=>"fail", "err"=>{"code"=>"100", "msg"=>"Error message from flickr"}}}

  before do
    @flickr = Flickr.new
  end

  describe 'search' do

    it 'should generate the correct search uri' do
      allow(@flickr).to receive_messages(response_hash: response_hash)
      @flickr.search "some free text"

      expect(@flickr.uri.to_s).to eq("https://api.flickr.com/services/rest/?api_key=#{FLICKR_API_KEY}&method=flickr.photos.search&text=some%20free%20text")
    end

    it 'should return a array of photos if succesful' do
      allow(@flickr).to receive_messages(response_hash: response_hash)
      photos = @flickr.search "some free text"

      expect(@flickr.error).to be_nil
      expect(photos.all? {|photo| photo.class.name == 'Photo'}).to be true
    end

    it 'should return a empty array if unsuccesful and set error' do
      allow(@flickr).to receive_messages(response_hash: nil)
      photos = @flickr.search "some free text"

      expect(@flickr.error).to eq("Something went wrong, please try again")
      expect(photos).to be_empty
    end

    it 'should return a empty array if status fail in response and set error returned by flickr api' do
      allow(@flickr).to receive_messages(response_hash: response_hash_fail)
      photos = @flickr.search "some free text"

      expect(@flickr.error).to eq("Error message from flickr")
      expect(photos).to be_empty
    end

    it 'should return a empty array if no photos are returned and set error message' do
      allow(@flickr).to receive_messages(response_hash: response_hash_no_photos)
      photos = @flickr.search "some free text"

      expect(@flickr.error).to eq("There are no photos that match your search")
      expect(photos).to be_empty
    end
  end
end
