class Document < ActiveRecord::Base
  attr_accessible :crawl_url, :user_text, :pdf
  
  has_attached_file :pdf, {
    :url => ":class/:id/:basename.:extension",
    :path => ":rails_root/public/:class/:id/:basename.:extension"
  }
end