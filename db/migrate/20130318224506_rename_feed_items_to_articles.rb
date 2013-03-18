class RenameFeedItemsToArticles < ActiveRecord::Migration
  rename_table :feed_items, :articles
end
