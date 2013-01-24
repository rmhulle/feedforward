class PodcastsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :go]

  def index
    @podcasts = Podcast.order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render json: @podcasts }
      format.rss
    end
  end

  # GET /links/1/go
  def go
    @podcast = Podcast.find(params[:id])
    @link_hit = LinkHit.find_or_create_by_linkable_type_and_linkable_id("Podcast", @podcast.id)
    @link_hit.increment! :count
    redirect_to @podcast.audio.url
  end

  def show
    @podcast = Podcast.find params[:id]
  end
end
