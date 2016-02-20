ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'webmock'
require 'vcr'
require 'simplecov'
require "capybara/rails"
SimpleCov.start('rails')

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
  end

  def create_nicole
    User.create(nickname: "NicoleHall",
    provider: "github",
    uid: "11447286",
    email: "nicolealexandrahall@gmail.com",
    name: "Nicole Hall",
    image: "https://avatars.githubusercontent.com/u/11447286?v=3",
    token: ENV["test_user_token"])
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = GithubToo::Application
    stub_omniauth
  end

  def stub_omniauth

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
          uid: "1234",
          info:
            {nickname: "NicoleHall",
            email: "nicolealexandrahall@gmail.com",
            name: "Nicole Hall",
            image: "https://avatars.githubusercontent.com/u/11447286?v=3"},
            urls:
              {GitHub: "https://github.com/NicoleHall"}},
            credentials:
          {token: ENV["test_user_token"], expires: false})
  end
end
