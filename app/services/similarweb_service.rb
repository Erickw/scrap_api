class SimilarwebService
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize
    @headers = {
      'User-Agent' => 'ScrapInfo'
    }
  end

  def get_website_info(url)
    response = self.class.get("/users/#{url}", headers: @headers)

    if response.success?
      response.parsed_response
    else
      response.code
    end
  end
end
