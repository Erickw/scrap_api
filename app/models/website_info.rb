class WebsiteInfo
  include Mongoid::Document
  field :url, type: String
  field :process_id, type: String
  field :login, type: String
  field :avatar_url, type: String
end
