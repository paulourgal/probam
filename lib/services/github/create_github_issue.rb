require 'octokit'
require 'services/base_service'

class CreateGithubIssue < BaseService

  attr_accessor :octokit_client, :repo_name, :issue, :issue_name, :issue_body

  def initialize(octokit_client, repo_name, issue_name, issue_body)
    @octokit_client = octokit_client
    @repo_name = repo_name
    @issue_name = issue_name
    @issue_body = issue_body
  end

  def call
    find_issue
    return nil if issue
    octokit_client.create_issue(repo_name, issue_name, issue_body)
  end

  private

  def found_issue?(issue)
    issue.title.include?(issue_name)
  end

  def find_issue
    issues = octokit_client.list_issues(repo_name)
    issues.each do |issue|
      @issue = issue if found_issue?(issue)
    end
  end

end
