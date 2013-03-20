class ArticlesController < ApplicationController
  def mark_read
    @article = Article.find params[:id]
    @article.mark_read

    render :status => 200
  end
  def mark_unread
    @article = Article.find params[:id]
    @article.mark_unread

    render :status => 200
  end

  def mark_saved
    @article = Article.find params[:id]
    @article.mark_saved

    render :status => 200
  end

  def mark_unsaved
    @article = Article.find params[:id]
    @article.mark_unsaved

    render :status => 200
  end
end
