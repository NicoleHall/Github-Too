
class GithubService
  attr_reader :conn, :user

  def initialize(user)
    @user = user
    @conn = Faraday.new(:url => 'https://api.github.com')
    @conn.headers = {'Authorization' => "token #{user.token}"}
  end


  def followers_count
    parse(conn.get("users/#{user.nickname}/followers")).count
  end

  def followers_details
    followers = parse(conn.get("users/#{user.nickname}/followers"))
    names = followers.map { |follower| follower["login"] }
    url = followers.map { |follower| follower["html_url"] }
    names.zip(url)
  end

  def starred_repos_count
    parse(conn.get("users/#{user.nickname}/starred")).count
  end

  def following_count
    parse(conn.get("/users/#{user.nickname}/following")).count
  end

  def following_list
    following = parse(conn.get("/users/#{user.nickname}/following"))
    names = following.map { |followed| followed["login"] }
    url = following.map { |followed| followed["html_url"] }
    names.zip(url)
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
