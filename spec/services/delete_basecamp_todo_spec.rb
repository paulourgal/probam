require 'logan'
require 'services/delete_basecamp_todo'

describe DeleteBasecampTodo do

  class ToDo

    attr_accessor :content

    def initialize(content="")
      @content = content
    end

  end

  class ToDoList

    attr_accessor :todos

    def initialize(todo=nil)
      @todos = []
      @todos << todo unless todo.nil?
    end

    def delete_todo(todo)
      nil
    end

  end

  let(:valid_issue) { { number: "123", title: "title", body: "body" } }
  let(:todo_list) { ToDoList.new(ToDo.new(valid_issue[:number])) }

  it 'responds to call' do
    expect(DeleteBasecampTodo).to respond_to(:call)
  end

  context '.call returns' do

    it 'nil when does not find todo' do
      expect(DeleteBasecampTodo.call(todo_list, "invalid")).to be_nil
    end

    it 'HTTParty::response when deletes the todo' do
      expect(todo_list).to receive(:delete_todo)
      DeleteBasecampTodo.call(todo_list, valid_issue[:number])
    end

  end

end
