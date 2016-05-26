require 'octokit'
require 'services/base_service'

class CreateGithubIssue < BaseService

  attr_accessor :access_token, :repo_name, :issue, :issue_name,
                :issue_body, :octokit_user

  def initialize(access_token, repo_name, issue_name, issue_body)
    @access_token = access_token
    @repo_name = repo_name
    @issue_name = issue_name
    @issue_body = issue_body
    @octokit_user = authenticate
  end

  def call
    find_issue
    return nil if issue
    octokit_user.create_issue(repo_name, issue_name, issue_body)
  end

  private

  def found_issue?(issue)
    issue.title.include?(issue_name)
  end

  def find_issue
    issues = octokit_user.list_issues(repo_name)
    issues.each do |issue|
      @issue = issue if found_issue?(issue)
    end
  end

  def authenticate
    Octokit::Client.new(access_token: access_token)
  end

end
