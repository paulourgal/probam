require "services/github/get_issues_from_github"
require_relative "../../mockings/octokit"

describe GetIssuesFromGithub do

  let(:repo_name) { "MYREPO" }
  let(:milestone_name) { "MYMILESTONE" }
  let(:milestone) { MockOctokit::Milestone.new(milestone_name) }
  let(:issue) { MockOctokit::Issue.new }
  let(:octokit_client) { MockOctokit::OctokitClient.new(milestone, issue) }

  it 'must respond to .call' do
    expect(GetIssuesFromGithub).to respond_to(:call)
  end

  it 'must return nil issues when does not find milestone' do
    expect(GetIssuesFromGithub.call(nil, octokit_client, repo_name, "all")).to be_nil
  end

  it 'must return a Array when find milestone' do
    expect(GetIssuesFromGithub.call(milestone, octokit_client, repo_name, "all"))
      .to be_a_kind_of(Array)
  end

end
