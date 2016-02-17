class UsersController < ApplicationController

  def show
    @followers = GithubService.new.followers_count(current_user)

  end

end
