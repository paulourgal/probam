require 'yaml'
require "services/github/authenticate_on_github"
require 'octokit'

describe AuthenticateOnGithub do

  let(:service) do
    AuthenticateOnGithub.new("teste")
  end

  it 'must respond to .call' do
    expect(AuthenticateOnGithub).to respond_to(:call)
  end

  it 'must respond to #call' do
    expect(service).to respond_to(:call)
  end

  it 'returns an instance of Octokit::Client' do
    expect(AuthenticateOnGithub.call("teste")).to be_a_kind_of(Octokit::Client)
  end

end
