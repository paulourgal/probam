require 'yaml'
require "services/create_github_milestone"
require 'octokit'

describe CreateGithubMilestone do

  let(:config) { YAML.load_file("lib/config.yml") }
  let(:access_token) { config["github"]["access_token"] }
  let(:repo_name) { "paulourgal/probam" }
  let(:milestone_name) { "backlog" }
  let(:service) do
    CreateGithubMilestone.new(access_token, repo_name, milestone_name)
  end

  it 'must respond to .call' do
    expect(CreateGithubMilestone).to respond_to(:call)
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

  context 'returns nil when' do

    # it 'does not find repository' do
    #   expect(CreateGithubMilestone.call(access_token, "invalid", milestone_name))
    #     .to be_nil
    # end

    it 'milestone_name is empty' do
      expect(CreateGithubMilestone.call(access_token, repo_name, ""))
        .to be_nil
    end

    it 'milestone_name already exist' do
      CreateGithubMilestone.call(access_token, repo_name, milestone_name)
      expect(CreateGithubMilestone.call(access_token, repo_name, milestone_name))
        .to be_nil
    end

  end

  it 'return a [Sawyer::Resource] A single milestone object when suceess' do
    expect(CreateGithubMilestone.call(access_token, repo_name, milestone_name))
      .to be_a_kind_of(Sawyer::Resource)
  end

end
