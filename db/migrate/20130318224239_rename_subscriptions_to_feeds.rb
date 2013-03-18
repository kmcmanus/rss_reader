class RenameSubscriptionsToFeeds < ActiveRecord::Migration
  rename_table :subscriptions, :feeds
end
