class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.datetime :date_recieved
      t.datetime :date_published
      t.string :title
      t.text :description
      t.string :url
      t.boolean :read
      t.boolean :saved

      t.timestamps
    end
  end
end
