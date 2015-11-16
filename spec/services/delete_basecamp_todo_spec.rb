require 'logan'
require 'services/delete_basecamp_todo'
require "services/create_todo_for_basecamp_from_a_issue"
require 'services/find_basecamp_project'
require "services/authenticate_on_basecamp"
require "services/find_basecamp_todo_list"

describe DeleteBasecampTodo do
  let(:valid_issue) { { number: "123", title: "title",
                        body: "body", labels: nil, assignee: nil } }

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
  let!(:todo) { CreateTodoForBasecampFromAIssue.call(valid_issue, todo_list) }

  it 'resposts to call'
  # it 'responds to call' do
  #   expect(DeleteBasecampTodo).to respond_to(:call)
  # end

  context '.call returns' do
    it 'nil when does not find todo'
    # it 'nil when does not find todo' do
    #   expect(DeleteBasecampTodo.call(todo_list, "invalid")).to be_nil
    # end

    it 'HTTParty::response when deletes the todo'
    # it 'HTTParty::response when deletes the todo' do
    #   result = DeleteBasecampTodo.call(todo_list, valid_issue[:number])
    #   expect(result.class).to eq(HTTParty::Response)
    # end
  end
end
