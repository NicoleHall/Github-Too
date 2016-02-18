class UsersController < ApplicationController

  def show
    @followers = current_github_service.followers_count
    @followers_details =  current_github_service.followers_details
    @starred_repos_count = current_github_service.starred_repos_count
    @following_count = current_github_service.following_count
    @following_list = current_github_service.following_list
    @most_recent_repo = current_github_service.most_recent_repo
    @messages = current_github_service.commits_for_most_recent_repo

    # Presenter Pattern
    # @DashboardUser = DashboardPresenter.new(current_user)
          # DashboardPresenter.followers
          # DashboardPresenter.followers_details
  end

end
