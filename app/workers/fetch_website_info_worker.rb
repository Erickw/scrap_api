class FetchWebsiteInfoWorker
  include Sidekiq::Worker

  def perform(url, process_id)
    begin
      similiarweb_service = SimilarwebService.new
      website_info = similiarweb_service.get_website_info(url)
      website_info_mapped = website_info_mapper.map(website_info, process_id)

      WebsiteInfo.new(website_info_mapped).save
    rescue => exception
      logger.error("Error occurred while processing Website Info data for #{url}: #{exception.message}")
      logger.error(exception.backtrace.join("\n"))

      raise exception
    end
  end

  def website_info_mapper
    WebsiteInfoMapper.new
  end

  def logger
    @logger ||= Logger.new("#{Rails.root}/log/sidekiq.log")
  end
end
