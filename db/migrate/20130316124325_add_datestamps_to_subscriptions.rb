class AddDatestampsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_scraped, :datetime
    add_column :subscriptions, :most_recent_article_posted_on, :datetime
  end
end
