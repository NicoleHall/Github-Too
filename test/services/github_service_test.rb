require './test/test_helper'

class GithubServiceTest < ActiveSupport::TestCase

  test "#followers_count" do
    VCR.use_cassette('github_service_followers_count') do
      user = create_nicole
      followers = GithubService.new(user).followers_count
      assert_equal 12, followers

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
