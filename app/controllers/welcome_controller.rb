class WelcomeController < ApplicationController
  def index
    @github_info = GithubUser.new('aferencz1987')
  end
end
