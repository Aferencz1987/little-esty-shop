class WelcomeController < ApplicationController
  def index
    require "pry"; binding.pry
    @github_info = GithubUser.new('aferencz1987')
  end
end
