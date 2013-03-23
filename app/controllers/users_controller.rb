class UsersController < ApplicationController
  before_filter :authenticate_user!

  def saved
    @title = "Saved Articles"
    @articles = current_user.articles.saved.desc

    render "feeds/show"
  end
end
