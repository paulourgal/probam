require 'yaml'
require "services/get_issues_from_github"
require 'octokit'

describe GetIssuesFromGithub do

  let(:config) { YAML.load_file("lib/config.yml") }
  let(:access_token) { config["github"]["access_token"] }
  let(:repo_name) { "caiena/ancora" }
  let(:milestone_name) { "backlog" }
  let(:state) { "all" }
  let(:service) do
    GetIssuesFromGithub.new(access_token, repo_name, milestone_name, state)
  end

  it 'must respond to .call' do
    expect(GetIssuesFromGithub).to respond_to(:call)
  end

  it 'must respond to #call' do
    expect(service).to respond_to(:call)
  end

  it 'must respond to #repo_name' do
    expect(service).to respond_to(:repo_name)
  end

  it 'must respond to #milestone_name' do
    expect(service).to respond_to(:milestone_name)
  end

  it 'must respond to #state' do
    expect(service).to respond_to(:state)
  end

  it 'must return nil when does not find issues' do
    expect(GetIssuesFromGithub.call(access_token, repo_name, "invalid", state))
      .to be_nil
  end

  it 'must return a Array of issues' do
    expect(GetIssuesFromGithub.call(access_token, repo_name, milestone_name, state))
      .to be_a_kind_of(Array)
  end

end
