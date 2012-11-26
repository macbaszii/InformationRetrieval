class Document < ActiveRecord::Base
  attr_accessible :crawl_url, :user_text, :pdf
  
  has_attached_file :pdf,
                    :url => "/assets/document/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/document/:id/:basename.:extension"
end