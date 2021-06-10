require 'rails_helper'
RSpec.describe GithubUser do
  it "has data" do
    mock_response = '{
    "login": "Aferencz1987",
    "id": 45580970,
    "node_id": "MDQ6VXNlcjQ1NTgwOTcw",
    "avatar_url": "https://avatars.githubusercontent.com/u/45580970?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/Aferencz1987",
    "html_url": "https://github.com/Aferencz1987",
    "followers_url": "https://api.github.com/users/Aferencz1987/followers",
    "following_url": "https://api.github.com/users/Aferencz1987/following{/other_user}",
    "gists_url": "https://api.github.com/users/Aferencz1987/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/Aferencz1987/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/Aferencz1987/subscriptions",
    "organizations_url": "https://api.github.com/users/Aferencz1987/orgs",
    "repos_url": "https://api.github.com/users/Aferencz1987/repos",
    "events_url": "https://api.github.com/users/Aferencz1987/events{/privacy}",
    "received_events_url": "https://api.github.com/users/Aferencz1987/received_events",
    "type": "User",
    "site_admin": false,
    "name": "Alex Ferencz",
    "company": null,
    "blog": "",
    "location": null,
    "email": null,
    "hireable": null,
    "bio": null,
    "twitter_username": null,
    "public_repos": 56,
    "public_gists": 8,
    "followers": 8,
    "following": 8,
    "created_at": "2018-12-04T01:57:39Z",
    "updated_at": "2021-06-02T22:32:19Z"
    }'
    allow(GithubService).to receive(:user_info).and_return(mock_response)
    # user = GithubUser.new('Aferencz1987')
    # expect(user.name).to eq('Alex Ferencz')
  end
end
