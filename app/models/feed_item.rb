class FeedItem < ActiveRecord::Base
  attr_accessible :date_published, :date_recieved, :description, :read, :saved, :subscription, :title, :url, :user
  belongs_to :user
  belongs_to :subscription

  def short_description
    if self.description.length <= 50
      self.description
    else
      self.description[0..47] + '...'
    end
  end

  def helpful_date_published
    date = date_published_offset
    if date.to_date == Date.today
      date.strftime "%I:%M %p"
    else
      date.strftime "%B %e, %Y"
    end
  end

  def date_published_offset
    @date_published_offset ||= self.date_published + DateTime.now.utc_offset
  end

  def scrape_from node
    scrape_attribute_from node, :date_published, 'pubDate'
    scrape_attribute_from node, :description, 'description'
    scrape_attribute_from node, :title, 'title'
    scrape_attribute_from node, :url, 'link'
  end

  private
  def scrape_attribute_from node, attribute, path
    node.xpath("./#{path}").each do |node_path|
      self[attribute] = node_path.inner_text
    end
  end

end
