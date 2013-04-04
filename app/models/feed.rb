require 'open-uri'
require 'nokogiri'
class Feed < ActiveRecord::Base
  attr_accessible :feed_url, :name, :site_url, :last_scraped, :most_recent_article_posted_on
  belongs_to :user
  validates_uniqueness_of :feed_url
  has_many :articles, :dependent => :destroy
  def load_base_data
    xml = self.get_xml

    items = xml.xpath("/rss/channel")
    puts items
    if items.empty? 
      xml.remove_namespaces!
      items = xml.xpath("/feed")
    end

    scrape_attribute_from items, :name, 'title'
    scrape_attribute_from items, :site_url, 'link'
  end

  def get_xml
    @get_xml ||= Nokogiri.XML(open(self.feed_url))
  end

  def scrape
    xml = get_xml
    last_published_date = DateTime.new 1970, 1, 1, 1, 1, 1
    type = "rss"
    items = xml.xpath("/rss/channel/item")

    if items.empty? 
      type = "atom"
      items = xml.xpath("/feed/entry")
    end

    items.each do |node|
      item = Article.new :feed => self, :user => self.user
      item.date_recieved = DateTime.now
      item.read = false
      item.saved = false
      item.scrape_from node, type
      
      if item.date_published > last_published_date
        last_published_date = item.date_published
      end

      if self.articles.where(:guid => item.guid).count == 0
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

    self.articles.where("date_recieved < '#{time}'").where(:saved => false).destroy_all
  end

  private
  def scrape_attribute_from node, attribute, path
    items = node.xpath()
    node.xpath("./#{path}").each do |node_path|
      self[attribute] = node_path.inner_text
    end
  end

end
