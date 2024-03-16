class WebsiteInfoController < ApplicationController
  before_action :generate_process_id, only: :create
  before_action :url_param, only: :create
  before_action :process_id_param, only: :show

  def create
    FetchWebsiteInfoWorker.perform_async(@url, @process_id)
    render json: { message: "Job to fetch enqueued successfully, you can request it by: #{@process_id}" } , status: :created
  end

  def index
    @website_infos = WebsiteInfo.all
    render json: @website_infos, status: :ok
  end

  def show
    @website_info = website_info_with_process_id(@process_id_param)

    if @website_info.blank?
      render json: {message: "The website info was not processed yet, try again later"}, status: :not_found
    else
      render json: @website_info, status: :ok
    end
  end

  private

  def url_param
    @url = params.require(:website_info).permit(:url).dig("url")
  end

  def process_id_param
    @process_id_param = params.require(:website_info).permit(:process_id).dig("process_id")
  end

  def generate_process_id
    loop do
      @process_id = SecureRandom.random_number(10000000)
      break unless website_info_with_process_id(@process_id).present?
    end
  end

  def website_info_with_process_id(process_id)
    WebsiteInfo.find_by(process_id: process_id)
  end
end
