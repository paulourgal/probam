require "services/github/find_milestone"
require_relative "../../mockings/octokit"

describe FindMilestone do

  let(:repo_name) { "MYREPO" }
  let(:milestone_name) { "MYMILESTONE" }
  let(:milestone) { MockOctokit::Milestone.new(milestone_name) }
  let(:octokit_client) { MockOctokit::OctokitClient.new(milestone) }

  it 'must return nil when does not find milestone' do
    expect(FindMilestone.call("INVALID", octokit_client, repo_name)).to be_nil
  end

  it 'must return milestone when find' do
    expect(FindMilestone.call(milestone_name, octokit_client, repo_name).title)
      .to eq(milestone_name)
  end

end
