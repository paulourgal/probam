require "services/github/create_github_issue"
require_relative "../../mockings/octokit"

describe CreateGithubIssue do

  let(:repo_name) { "MYREPO" }
  let(:issue_name) { "MYISSUE" }
  let(:issue_body) { "ISSUEBODY" }
  let(:issue) { MockOctokit::Issue.new(issue_name) }
  let(:milestone_name) { "MYMILESTONE" }
  let(:milestone) { MockOctokit::Milestone.new(milestone_name) }
  let(:octokit_client) { MockOctokit::OctokitClient.new(milestone, issue) }
  let(:new_issue_name) { "NEWISSUE" }

  context 'returns nil when' do

    it 'issue_name is empty' do
      expect(CreateGithubIssue.call(octokit_client, repo_name, "", issue_body)).to be_nil
    end

    it 'issue_name already exist' do
      expect(CreateGithubIssue.call(octokit_client, repo_name, issue_name, issue_body)).to be_nil
    end

  end

  it 'return the issue created when suceess' do
    expect(CreateGithubIssue.call(octokit_client, repo_name, new_issue_name, issue_body).title)
      .to eq(new_issue_name)
  end

end
