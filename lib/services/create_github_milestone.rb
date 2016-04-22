require 'octokit'

class CreateGithubMilestone

  def self.call(access_token, repo_name, milestone_name)
    self.new(access_token, repo_name, milestone_name).call
  end

  attr_accessor :access_token, :repo_name, :milestone_name,
                :milestone, :octokit_user

  def initialize(access_token, repo_name, milestone_name)
    @access_token = access_token
    @repo_name = repo_name
    @milestone_name = milestone_name
    @octokit_user = authenticate
  end

  def call
    find_milestone
    return nil if milestone
    octokit_user.create_milestone(repo_name, milestone_name)
  end

  private

  def found_milestone?(milestone)
    milestone.title.include?(milestone_name)
  end

  def find_milestone
    milestones = octokit_user.list_milestones(repo_name)
    milestones.each do |milestone|
      @milestone = milestone if found_milestone?(milestone)
    end
  end

  def authenticate
    Octokit::Client.new(access_token: access_token)
  end

end
