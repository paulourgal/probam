require 'services/basecamp/delete_basecamp_todo'
require_relative "../../mockings/logan"

describe DeleteBasecampTodo do

  let(:valid_issue) { { number: "123", title: "title", body: "body" } }
  let(:todo) { MockLogan::ToDo.new(valid_issue[:number]) }
  let(:todo_list) { MockLogan::ToDoList.new("MYTODOLIST", todo) }

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
