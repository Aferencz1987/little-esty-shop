class GithubUser
  attr_reader :date_joined, :name

  def initialize(username)
    github_data = GithubService.user_info(username)
    @date_joined = github_data["created_at"]
    # @name = github_data[:name]
  end
  def valid?
    if @date_joined.nil? || @name.nil?
      return false
    else
      return true
    end
  end
end
