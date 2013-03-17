require 'open-uri'
require 'nokogiri'
class Subscription < ActiveRecord::Base
  attr_accessible :feed_url, :name, :site_url, :last_scraped, :most_recent_article_posted_on
  belongs_to :user
  has_many :feed_items
  def load_base_data
    xml = self.get_xml

    scrape_attribute_from xml, :name, 'title'
    scrape_attribute_from xml, :site_url, 'link'

  end

  def get_xml
    @get_xml ||= Nokogiri.XML(open(self.feed_url))
  end

  def scrape
    xml = get_xml
    last_published_date = DateTime.new 1970, 1, 1, 1, 1, 1
    xml.xpath("/rss/channel/item").each do |node|
      item = FeedItem.new :subscription => self, :user => self.user
      item.date_recieved = DateTime.now
      item.read = false
      item.saved = false
      item.scrape_from node
      
      if item.date_published > last_published_date
        last_published_date = item.date_published
      end

      if self.feed_items.where(:guid => item.guid).count == 0
        item.save!
      else
        item.destroy
      end
    end

    self.last_scraped = DateTime.now
    self.most_recent_article_posted_on = last_published_date
  end

  def clean
    time = DateTime.now - 1

    self.feed_items.where(:date_recieved < time).destroy_all
  end

  private
  def scrape_attribute_from node, attribute, path
    node.xpath("/rss/channel/#{path}").each do |node_path|
      self[attribute] = node_path.inner_text
    end
  end

end
