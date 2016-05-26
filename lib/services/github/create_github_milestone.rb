require 'octokit'
require 'services/base_service'
require 'services/github/find_milestone'

class CreateGithubMilestone < BaseService

  attr_accessor :octokit_client, :milestone_name, :milestone, :repo_name

  def initialize(octokit_client, repo_name, milestone_name)
    @octokit_client = octokit_client
    @repo_name = repo_name
    @milestone_name = milestone_name
  end

  def call
    return nil if milestone_name.empty?
    @milestone = FindMilestone.call(milestone_name, octokit_client, repo_name)
    return nil if @milestone
    octokit_client.create_milestone(repo_name, milestone_name)
  end

end
