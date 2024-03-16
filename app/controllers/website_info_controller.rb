class WebsiteInfoController < ApplicationController

  def create
    process_id = generate_process_id

    FetchWebsiteInfoWorker.perform_async(url, process_id)
    render json: { message: "Job to fetch enqueued successfully, you can request it by: #{process_id}" } , status: :created
  end

  def index
    @website_infos = WebsiteInfo.all
    render json: @website_infos, status: :ok
  end

  def show
    @website_info = website_info_with_proccess_id(process_id_param)

    if @website_info.blank?
      render json: {message: "The website info was not processed yet, try again later"}, status: :not_found
    else
      render json: @website_info, status: :ok
    end

  end

  private

  def url
    params.require(:website_info).permit(:url).dig("url")
  end

  def process_id_param
    params.require(:website_info).permit(:process_id).dig("process_id")
  end

  def generate_process_id
    procces_id = SecureRandom.random_number(10000000)

    loop do
      break unless website_info_with_proccess_id(procces_id).present?
    end
    procces_id
  end

  def website_info_with_proccess_id(procces_id)
    WebsiteInfo.find_by(process_id: procces_id)
  end
end
