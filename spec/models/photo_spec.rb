require 'rails_helper'

describe Photo do

  before do
    @photo = Photo.new({'id' => '1', 'secret' => '2', 'server' => '3', 'farm' => '4'})
  end

  it "should respond to 'id'" do
    expect(@photo).to respond_to(:id)
  end

  it "should respond to 'secret'" do
    expect(@photo).to respond_to(:secret)
  end

  it "should respond to 'server'" do
    expect(@photo).to respond_to(:server)
  end

  it "should respond to 'farm'" do
    expect(@photo).to respond_to(:farm)
  end

  it "should generate the correct small url for photo" do
    expect(@photo.url_small).to eq("https://farm4.staticflickr.com/3/1_2_q.jpg")
  end

  it "should generate the correct large url for photo" do
    expect(@photo.url_large).to eq("https://farm4.staticflickr.com/3/1_2_c.jpg")
  end
end
