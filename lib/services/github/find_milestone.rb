require 'octokit'
require_relative '../base_service'

class FindMilestone < BaseService

  attr_reader :milestone_name, :octokit_client, :repo_name

  def initialize(name, octokit_client, repo_name)
    @milestone_name = name
    @octokit_client = octokit_client
    @repo_name = repo_name
  end

  def call
    octokit_client.list_milestones(repo_name).find { |m| m.title.eql?(milestone_name) }
  end

end
