class AddUserToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :int
  end
end
