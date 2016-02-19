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

#if this test fails, delete the cassette.
  test "#following_list" do
    VCR.use_cassette('github_service_following_list') do
      user = create_nicole
      following_list = GithubService.new(user).following_list
      assert_equal "JoshCheek", following_list.first[0]
      assert_equal "https://github.com/JoshCheek", following_list.first[1]
    end
  end

  test "#most_recent_repo" do
    VCR.use_cassette('gitserv_most_recent_repo') do
      user = create_nicole
      assert_equal "Github-Too", GithubService.new(user).most_recent_repo
    end
  end

  test "#commits_for_most_recent_repo" do
    VCR.use_cassette('gitsev_commits_recent_repo') do
      user = create_nicole
      repo = "Github-Too"
      commits = GithubService.new(user).commits_for_most_recent_repo
      commit_message = "users controller has a show method and the GitHub Service has a followers count method"
      assert_equal 10, commits.count
      assert_equal commit_message, commits.first
    end
  end

  test "#activity_of_followings" do
    VCR.use_cassette('gitserv_activity_of_followings') do
      user = create_nicole
      first_result = GithubService.new(user).activity_of_followings.first.person
      assert_equal "JoshCheek", first_result
    end
  end

  test "#my_repositories" do
    VCR.use_cassette('gitserv_my_repositories') do
      user = create_nicole
      assert_equal "Github-Too", GithubService.new(user).my_repositories.first
    end
  end

  test "#my_organizations" do
    VCR.use_cassette('gitserv_my_organizations') do
      user = create_nicole
      assert_equal 0, GithubService.new(user).my_organizations.count
    end
  end

end
