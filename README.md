
## GitHub Too

In this project, I am focusing on consuming and working with data from the public GitHub API.
GitHubToo is a vehicle for learning important skills such as:
  *Authenticating with credentials used with a third-party application. To do this i use the OAuth protocol and the OmniAuth Gem
  *Making GET requests to API endpoints
  *Parsing the response body to pull out desired pieces of information

GitHubToo will rely on test-driven-development. Tests are written using Minitest

The user of the Github Too app see the following information produced from GitHub response bodies:
  *Profile Picture
  *Number of starred repos
  *Count of followers
  *List of followers and the associated GitHub profiles for those followers
  *Count of followed users
  *List of the past 10 commits for the repo most recently pushed to GitHub
  *List of recent commit messages from followed users
  *List of organizations
  *List of all repositories

The user of the GitHub Too app will see the following information produced from screen-scraping using the Nokogiri Gem
  *Contributions in the last year
  *Longest streak
  *Current Streak

To simulate an on-the-job experience of working for a client, each feature was overseen by a Turing staff member playing the role of a client. Development of features were based on client requests and feedback.

Waffle.io was used as the project management too to facilitate agile development
