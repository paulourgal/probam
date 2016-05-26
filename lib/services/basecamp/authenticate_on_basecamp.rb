require 'logan'
require_relative '../base_service'

class AuthenticateOnBasecamp < BaseService

  attr_accessor :basecamp, :id, :password, :username

  def initialize(id, username, password)
    @basecamp = nil
    @id = id
    @password = password
    @username = username
  end

  def call
    basecamp_id = id
    auth_hash = { username: username, password:  password }
    user_agent = "LoganUserAgent (email@example.com)"

    basecamp = Logan::Client.new(basecamp_id, auth_hash, user_agent)
  end

end
