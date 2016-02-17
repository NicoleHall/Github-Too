ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'webmock'
require 'vcr'

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
    token: "6a21db5cb96be52f4d0acbd4d8410ca0f6b74e0e")
  end
end
