require 'octokit'
require_relative '../base_service'

class AuthenticateOnGithub < BaseService

  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def call
    Octokit::Client.new(access_token: access_token)
  end
end
