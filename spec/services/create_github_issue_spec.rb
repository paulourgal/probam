require 'yaml'
require "services/create_github_issue"
require 'octokit'

describe CreateGithubIssue do

  let(:config) { YAML.load_file("lib/config.yml") }
  let(:access_token) { config["github"]["access_token"] }
  let(:repo_name) { "paulourgal/probam" }
  let(:issue_name) { "Issue" }
  let(:issue_body) { "Issue Body" }
  let(:service) do
    CreateGithubIssue.new(access_token, repo_name, issue_name, issue_body)
  end

  it 'must respond to .call' do
    expect(CreateGithubIssue).to respond_to(:call)
  end

  it 'must respond to #call' do
    expect(service).to respond_to(:call)
  end

  it 'must respond to #repo_name' do
    expect(service).to respond_to(:repo_name)
  end

  context 'returns nil when' do

    # it 'does not find repository' do
    #   expect(CreateGithubIssue.call(access_token, "invalid", milestone_name))
    #     .to be_nil
    # end

    it 'issue_name is empty' do
      expect(CreateGithubIssue.call(access_token, repo_name, "", issue_body))
        .to be_nil
    end

    it 'issue_name already exist' do
      CreateGithubIssue.call(access_token, repo_name, "TESTE", issue_body)
      expect(CreateGithubIssue.call(access_token, repo_name, "TESTE", issue_body))
        .to be_nil
    end

  end

  it 'return a [Sawyer::Resource] Your newly created issue when suceess' do
    expect(CreateGithubIssue.call(access_token, repo_name, issue_name, issue_body))
      .to be_a_kind_of(Sawyer::Resource)
  end

end
