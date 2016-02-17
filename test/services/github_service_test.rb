require './test/test_helper'

class GithubServiceTest < ActiveSupport::TestCase

  test "#followers_count" do
    VCR.use_cassette('github_service_followers_count') do
      user = create_nicole
      followers = GithubService.new(user).followers_count
      assert_equal 12, followers
    end
  end

  test "#followers_details" do
    VCR.use_cassette('github_service_followers_details') do
      user = create_nicole
      followers_list = GithubService.new(user).followers_details
      assert_equal "mikedao", followers_list.first[0]
      assert_equal "https://github.com/mikedao", followers_list.first[1]
    end
  end

  test "#starred_repos_count" do
    VCR.use_cassette('github_service_starred_repos_count') do
      user = create_nicole
      starred_repos = GithubService.new(user).starred_repos_count
      assert_equal 0, starred_repos
    end
  end




end
