
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

  def most_recent_repo
    all_repos = parse(conn.get("/users/#{user.nickname}/repos"))
    sorted_repos = all_repos.sort_by do |repo|
      repo["updated_at"]
    end
    sorted_repos.last
  end

  def commits_for_current_user
    #View a summary feed of my recent activity (recent commits)

    commits = parse(conn.get("repos/#{user.nickname}/#{most_recent_repo["name"]}/commits"))
    messages = commits.map { |commit| commit["commit"]["message"] }

  end

  def longest_streak
    repos_url = parse(conn.get("users/#{user.nickname}"))["repos_url"]
    commit_urls = parse(conn.get(repos_url)).map { |repo| repo["commits_url"] }
    all_of_the_commits = commit_urls.map { |url| parse(conn.get(url[0..-7])) }.flatten
    sorted_dates = all_of_the_commits.sort_by do |commit_object|
      require 'pry'; binding.pry
    commit_object["commit"]["author"]["date"]
    end
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
