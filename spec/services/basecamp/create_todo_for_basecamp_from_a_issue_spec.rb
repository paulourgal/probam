require "spec_helper"
require "services/basecamp/create_todo_for_basecamp_from_a_issue"
require_relative "../../mockings/logan"

describe CreateTodoForBasecampFromAIssue do

  let(:invalid_issue) { { number: nil, title: "title", body: "body" } }
  let(:valid_issue) { { number: "123", title: "title", body: "body" } }
  let(:new_valid_issue) { { number: "1234", title: "title", body: "body" } }
  let(:todo) { MockLogan::ToDo.new(valid_issue[:number]) }
  let(:todo_list) { MockLogan::ToDoList.new("MYTODOLIST", todo) }

  it 'responds to call' do
    expect(CreateTodoForBasecampFromAIssue).to respond_to(:call)
  end

  context '.call' do

    it 'returns nil when Story is invalid' do
      expect(CreateTodoForBasecampFromAIssue.call(invalid_issue, todo_list))
        .to be_nil
    end

    it 'returns a Logan::Todo when Story is valid' do
      expect(CreateTodoForBasecampFromAIssue.call(new_valid_issue, todo_list))
        .to be_a_kind_of(Story)
    end

    it 'returns nil when issue is already on basecamp' do
      expect(CreateTodoForBasecampFromAIssue.call(valid_issue, todo_list))
        .to be_nil
    end

  end

end
