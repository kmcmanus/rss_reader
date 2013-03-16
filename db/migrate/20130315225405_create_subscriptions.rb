class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :type
      t.string :feed_url
      t.string :site_url

      t.timestamps
    end
  end
end
