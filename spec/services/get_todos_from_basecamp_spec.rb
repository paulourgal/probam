require 'yaml'
require 'logan'
require 'services/find_basecamp_project'
require "services/authenticate_on_basecamp"
require "services/find_basecamp_todo_list"
require "services/get_todos_from_basecamp"

describe GetTodosFromBasecamp do

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
  let(:project) { FindBasecampProject.call(basecamp, project_name) }
  let(:todo_list_name) { config["basecamp"]["projects"]["ancora"]["todolist"] }

  it 'responds to call' do
    expect(GetTodosFromBasecamp).to respond_to(:call)
  end

  it 'must return a Array of issues' do
    todo_list = FindBasecampTodoList.call(project, todo_list_name)
    expect(GetTodosFromBasecamp.call(todo_list)).to be_a_kind_of(Array)
  end

end
