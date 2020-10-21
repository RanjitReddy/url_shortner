class ShortLink < ApplicationRecord
  validates_presence_of :url
  validates :url, :url => true, :allow_blank => true
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: "insufficient length of url", :allow_blank => true

  before_validation :generate_slug
  
  def generate_slug
    self.slug = SecureRandom.uuid[0..7] if self.slug.nil? || self.slug.empty?
    true
  end

  def self.shorten(url, slug = '')
    # return shortner URL
    link = ShortLink.where(url: url, slug: slug).first
    return link.short if link 
      
    # create a new
    link = ShortLink.new(url: url, slug: slug)
    return link.short if link.save
      
    # if slug is taken, try to add random characters
    ShortLink.shorten(url, slug + SecureRandom.uuid[0..2])
  end

  # access to the shortened link
  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end
end
