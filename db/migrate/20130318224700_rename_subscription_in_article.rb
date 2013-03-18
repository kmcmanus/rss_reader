class RenameSubscriptionInArticle < ActiveRecord::Migration
  rename_column :articles, :subscription_id, :feed_id

end
