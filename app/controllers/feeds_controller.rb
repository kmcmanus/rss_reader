class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @feeds = current_user.feeds
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = current_user.feeds.create!
    if @feed.update_attributes(params['feed'])
      @feed.load_base_data
      @feed.scrape
      @feed.save!
      redirect_to :action => 'index'
    else
      redirect_to :action => 'edit'
    end
  end

  def show    
    @feed = Feed.find params[:id]
    @title = @feed.name

    @articles = @feed.articles.desc
  end
end
