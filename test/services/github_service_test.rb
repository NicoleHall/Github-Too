require './test/test_helper'

class GithubServiceTest < ActiveSupport::TestCase

  test "#followers_count" do
    VCR.use_cassette('github_service_followers_count') do
      user = create_nicole
      assert_equal 12, GithubService.new(user).followers_count
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
      assert_equal 0, GithubService.new(user).starred_repos_count
    end
  end

  test "#following_count" do
    VCR.use_cassette('github_service_following_count') do
      user = create_nicole
      assert_equal 8, GithubService.new(user).following_count
    end
  end

  test "#following_list" do
    VCR.use_cassette('github_service_following_list') do
      user = create_nicole
      following_list = GithubService.new(user).following_list
      assert_equal "JoshCheek", following_list.first[0]
      assert_equal "https://github.com/JoshCheek", following_list.first[1]
    end
  end


end