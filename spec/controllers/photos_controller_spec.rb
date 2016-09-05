require 'rails_helper'

describe PhotosController do
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

  describe 'GET search' do
    it 'should return a array of posts' do
      Flickr.any_instance.stub(:response_hash).and_return(response_hash)
      get :search, search: 'Some free text'

      expect(assigns(:photos).all? {|photo| photo.class.name == 'Photo'}).to be true
    end
  end

  describe 'GET index' do
    it 'should have a 200 status response' do
      get :index

      expect(response.status).to eq(200)
    end
  end
end
