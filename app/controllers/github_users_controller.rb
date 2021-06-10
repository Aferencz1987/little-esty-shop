class GithubUsersController < ApplicationController
  def show
    @github_info = GithubUser.new(params[:id])
  end
end
