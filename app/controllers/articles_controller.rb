class ArticlesController < ApplicationController
  def mark_read
    @article = Article.find params[:id]
    @article.mark_read

    render :nothing => true
  end
  def mark_unread
    @article = Article.find params[:id]
    @article.mark_unread

    render :nothing => true
  end

  def toggle_saved
    @article = Article.find params[:id]
    @article.toggle_saved

    render :nothing => true
  end

end
