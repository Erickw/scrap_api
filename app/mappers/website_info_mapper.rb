class WebsiteInfoMapper
  def map(data, process_id)
    {
      :id => data.dig("id"),
      :process_id => process_id,
      :login => data.dig("login"),
      :avatar_url => data.dig("avatar_url")
    }
  end
end
