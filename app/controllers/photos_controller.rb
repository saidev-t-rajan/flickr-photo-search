class PhotosController < ApplicationController

  def index

  end

  def search
    if session[:searched].blank? || session[:searched][:search] != params[:search]
      flickr = Flickr.new
      session[:searched] = { search: params[:search], photos: flickr.search(params[:search]) }
    end

    @photos = session[:searched][:photos].paginate(page: params[:page], per_page: 12)

    flash.now[:error] = flickr.error if flickr && flickr.error

    render :index
  end
end