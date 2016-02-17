
class GithubService
  attr_reader :conn

  def initialize

  @conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
   faraday.request  :url_encoded             # form-encode POST params
   faraday.response :logger                  # log requests to STDOUT
   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end
 end


  def followers_count(user)
    parse(conn.get("users/#{user.nickname}/followers")).count
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
