require 'logan'
require "services/create_todo_for_basecamp_from_a_issue"
require 'services/find_basecamp_project'
require "services/authenticate_on_basecamp"
require "services/find_basecamp_todo_list"
require 'services/delete_basecamp_todo'

describe CreateTodoForBasecampFromAIssue do

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
  let(:todo_list) { FindBasecampTodoList.call(project, todo_list_name) }

  let(:invalid_issue) { { number: nil, title: "title", body: "body", labels: nil, assignee: nil } }
  let(:valid_issue) { { number: "123", title: "title", body: "body", labels: nil, assignee: nil } }

  it 'responds to call' do
    expect(CreateTodoForBasecampFromAIssue).to respond_to(:call)
  end

  context '.call' do

    it 'returns nil when Story is invalid' do
      expect(CreateTodoForBasecampFromAIssue.call(invalid_issue, todo_list))
        .to be_nil
    end

    it 'returns a Logan::Todo when Story is valid' do
      expect(CreateTodoForBasecampFromAIssue.call(valid_issue, todo_list))
        .to be_a_kind_of(Story)
    end

    it 'returns nil when issue is already on basecamp' do
      expect(CreateTodoForBasecampFromAIssue.call(valid_issue, todo_list))
        .to be_nil

      DeleteBasecampTodo.call(todo_list, valid_issue[:number])
    end

  end

end
