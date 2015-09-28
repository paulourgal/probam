require 'logan'
require 'services/find_basecamp_project'
require "services/authenticate_on_basecamp"

describe FindBasecampProject do

  let(:config) { YAML.load_file("lib/config.yml") }
  let(:basecamp_id) { config["basecamp"]["id"] }
  let(:basecamp_username) { config["basecamp"]["username"] }
  let(:basecamp_password) { config["basecamp"]["password"] }
  let(:basecamp) do
    AuthenticateOnBasecamp.call(
      basecamp_id, basecamp_username, basecamp_password
    )
  end
  let(:project_name) { config["basecamp"]["projects"]["ancora"]["name"] }

  it 'responds to call' do
    expect(FindBasecampProject).to respond_to(:call)
  end

  context '.call returns' do

    it 'nil when does not find project' do
      expect(FindBasecampProject.call(basecamp, "INVALID")).to be_nil
    end

    it 'Logan::Project when find project' do
      expect(FindBasecampProject.call(basecamp, project_name))
        .to be_a_kind_of(Logan::Project)
    end

  end

end
