require "services/github/create_github_milestone"
require_relative "../../mockings/octokit"

describe CreateGithubMilestone do

  let(:repo_name) { "MYREPO" }
  let(:new_milestone) { "NEWMILESTONE" }
  let(:milestone_name) { "MYMILESTONE" }
  let(:milestone) { MockOctokit::Milestone.new(milestone_name) }
  let(:octokit_client) { MockOctokit::OctokitClient.new(milestone) }

  context 'returns nil when' do

    it 'milestone_name is empty' do
      expect(CreateGithubMilestone.call(octokit_client, repo_name, "")).to be_nil
    end

    it 'milestone_name already exist' do
      expect(CreateGithubMilestone.call(octokit_client, repo_name, milestone_name)).to be_nil
    end

  end

  it 'return the milestone created when success' do
    expect(CreateGithubMilestone.call(octokit_client, repo_name, new_milestone).title)
      .to eq(new_milestone)
  end

end
