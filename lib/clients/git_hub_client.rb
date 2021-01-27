class GitHubClient
  ROOT_ENDPOINT = 'https://api.github.com'.freeze
  ACCESS_TOKEN = '34dae244d09b1bc9a2743844d165d284d185b934'.freeze

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{ACCESS_TOKEN}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
