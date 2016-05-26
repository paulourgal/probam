require 'octokit'
require 'services/base_service'

class GetIssuesFromGithub < BaseService

  ISSUES_PER_PAGE = 30

  attr_accessor :issues, :milestone, :state, :octokit_client, :repo_name

  def initialize(milestone, octokit_client, repo_name, state)
    @milestone = milestone
    @octokit_client = octokit_client
    @repo_name = repo_name
    @state = state || 'open'
    @issues = []
  end

  def call
    return nil if milestone.nil?
    set_issues_from_page
    issues
  end

  private

  def pages
    p = total_issues / ISSUES_PER_PAGE
    (total_issues % ISSUES_PER_PAGE) > 0 ? (p + 1) : p
  end

  def set_issues_from_page
    (1..pages).each do |page|
      aux = octokit_client.issues(repo_name, milestone: milestone.number, state: state, page: page)
      aux.each { |issue| @issues << issue unless issue.nil? }
    end
  end

  def total_issues
    milestone.open_issues + milestone.closed_issues
  end

end
