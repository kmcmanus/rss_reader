class RemoveTypeFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :type
  end

  def down
    add_column :subscriptions, :type, :string
  end
end
