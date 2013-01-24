class LinksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :go]

  # GET /links
  def index
    @links = Link.order("created_at DESC").paginate(page: params[:page], per_page: 20)
    @link = Link.new

    respond_to do |format|
      format.html
      format.json { render json: @links }
      format.rss
    end
  end

  # GET /links/1/go
  def go
    @link = Link.find(params[:id])
    @link_hit = LinkHit.find_or_create_by_linkable_type_and_linkable_id("Link", @link.id)
    @link_hit.increment! :count
    redirect_to @link.url
  end

  # GET /links/1
  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links
  def create
    @link = current_user.links.new(params[:link])

    if @link.save
      redirect_to links_path, notice: 'Link was successfully created.'
    else
      render action: "new"
    end
  end

  def title
    require 'open-uri'
    open(params[:page]) do |f|
      f.set_encoding "UTF-8"
      render text: f.read[/<title>\s*(.*)\s*<\/title>/iu, 1]
    end
  end
end
