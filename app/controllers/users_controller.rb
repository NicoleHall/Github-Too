class UsersController < ApplicationController

  def show
    # @user_show_info = current_github_service.get_user_info
    # @user_show_info['followers_count']

    @followers = current_github_service.followers_count
    @followers_details =  current_github_service.followers_details
    @starred_repos_count = current_github_service.starred_repos_count
    @following_count = current_github_service.following_count
    @following_list = current_github_service.following_list
    @longest_streak = current_github_service.longest_streak
    @current_streak = current_github_service.current_streak
    @contributions = current_github_service.contributions
    @activity_of_followings =current_github_service.activity_of_followings

  end

  def index
    @most_recent_repo = current_github_service.most_recent_repo
    @messages = current_github_service.commits_for_most_recent_repo
    @my_repos = current_github_service.my_repositories
    @my_organizations = current_github_service.my_organizations
  end

end
