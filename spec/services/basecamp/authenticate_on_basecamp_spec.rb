require 'yaml'
require 'logan'
require "services/basecamp/authenticate_on_basecamp"

describe AuthenticateOnBasecamp do

  let(:config) { YAML.load_file("lib/config.yml") }
  let(:basecamp_id) { config["basecamp"]["id"] }
  let(:basecamp_username) { config["basecamp"]["username"] }
  let(:basecamp_password) { config["basecamp"]["password"] }

  it 'responds to call' do
    expect(AuthenticateOnBasecamp).to respond_to(:call)
  end

  it 'returns an instance of Logan::Client' do
    expect(AuthenticateOnBasecamp.call(
      basecamp_id, basecamp_username, basecamp_password
    )).to be_a_kind_of(Logan::Client)
  end

end
