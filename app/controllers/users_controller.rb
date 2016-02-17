class UsersController < ApplicationController

  def show
    @followers = current_github_service.followers_count
    @followers_details =  current_github_service.followers_details
    @starred_repos_count = current_github_service.starred_repos_count
    @following_count = current_github_service.following_count
    @following_list = current_github_service.following_list


    # Presenter Pattern
    # @DashboardUser = DashboardPresenter.new(current_user)
          # DashboardPresenter.followers
          # DashboardPresenter.followers_details
  end

end
