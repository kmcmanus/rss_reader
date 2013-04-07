class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = "Your Feeds"

    @articles = current_user.articles.unread.desc

    render 'show'
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
      flash[:notice] = "You have now subscribed to #{@feed.name}."
    else
      redirect_to :action => 'edit'
    end
  end

  def show    
    @feed = Feed.find params[:id]
    @title = @feed.name

    @articles = @feed.articles.desc
  end

  def refresh
    current_user.feeds.each do |feed|
      feed.scrape
    end

    render :nothing => true
  end

  def mark_all_read
    params["items"].values.each do |item|
      article = Article.find(item['article'].to_i)
      article.mark_read
    end
    render :nothing => true
  end
  
end
