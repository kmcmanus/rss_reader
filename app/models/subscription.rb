require 'open-uri'
require 'nokogiri'
class Subscription < ActiveRecord::Base
  attr_accessible :feed_url, :name, :site_url, :type
  belongs_to :user

  def load_base_data
    xml = self.get_xml

    xml.xpath("/rss/channel/title").each do |title|
      self.name = title.inner_text
    end

    xml.xpath("/rss/channel/link").each do |link|
      self.site_url = link.inner_text
    end

  end

  def get_xml
    Nokogiri.XML(open(self.feed_url))
  end
end
