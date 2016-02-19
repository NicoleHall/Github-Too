require 'nokogiri'
require 'open-uri'

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
      repo["pushed_at"]
    end
    sorted_repos.last["name"]
  end

  def commits_for_most_recent_repo
    commits = parse(conn.get("repos/#{user.nickname}/#{most_recent_repo}/commits"))
    recents = commits.sort_by { |commit| commit["date"]}.first(10)
    recents.map { |commit| commit["commit"]["message"] }.reverse
  end

  def activity_of_followings
    following = parse(conn.get("/users/#{user.nickname}/following"))
    names = following.map { |followed| followed["login"] }
    names.each { |name| parse(conn.get("/users/#{name}/events")) }

    events = names.map { |name| parse(conn.get("users/#{name}/events")).sample(3)}.flatten
    pushes = events.select { |event| event["type"] == "PushEvent"}
    pushes.map do |push|
      OpenStruct.new({
        person: push["actor"]["login"],
        repo: push["repo"]["name"],
        comment: push["payload"]["commits"].first["message"][0..20]
      })
    end
  end


  def longest_streak
    doc = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    doc.xpath('//*[@id="contributions-calendar"]/div[4]/span[2]').text
  end

  def current_streak
    doc = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    doc.xpath('//*[@id="contributions-calendar"]/div[5]/span[2]').text
  end

  def contributions
    doc = Nokogiri::HTML(open("https://github.com/#{user.nickname}"))
    doc.xpath('//*[@id="contributions-calendar"]/div[3]/span[2]').text
  end

  def parse(response)
    JSON.parse(response.body)
  end

end
