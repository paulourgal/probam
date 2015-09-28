require 'logan'
require 'services/find_basecamp_project'
require "services/authenticate_on_basecamp"
require "services/find_basecamp_todo_list"

describe FindBasecampTodoList do

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
    expect(FindBasecampTodoList).to respond_to(:call)
  end

  context '.call returns' do

    it 'nil when does not find todo-list' do
      expect(FindBasecampTodoList.call(project, "INVALID"))
        .to be_nil
    end

    it 'Logan::TodoList when find todo-list' do
      expect(FindBasecampTodoList.call(project, todo_list_name))
        .to be_a_kind_of(Logan::TodoList)
    end

  end

end
