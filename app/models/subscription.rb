class Subscription < ActiveRecord::Base
  attr_accessible :feed_url, :name, :site_url, :type
end
