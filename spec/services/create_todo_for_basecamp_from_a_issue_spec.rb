require 'logan'
require "services/create_todo_for_basecamp_from_a_issue"

describe CreateTodoForBasecampFromAIssue do

  class ToDo

    attr_accessor :content

    def initialize(content="")
      @content = content
    end

    def create_comment(comment)
      nil
    end
  end

  class ToDoList

    attr_accessor :todos

    def initialize(todo=nil)
      @todos = []
      @todos << todo unless todo.nil?
    end

    def create_todo(todo)
      ToDo.new
    end

  end

  let(:todo_list) { ToDoList.new }
  let(:invalid_issue) { { number: nil, title: "title", body: "body" } }
  let(:valid_issue) { { number: "123", title: "title", body: "body" } }

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
      todo = ToDo.new(valid_issue[:number])
      todo_list = ToDoList.new(todo)
      expect(CreateTodoForBasecampFromAIssue.call(valid_issue, todo_list))
        .to be_nil
    end

  end

end
