require "services/basecamp/find_basecamp_todo_list"
require_relative "../../mockings/logan"

describe FindBasecampTodoList do

  let(:todolist_name) { "MYTODOLIST" }
  let(:todolist) { MockLogan::ToDoList.new(todolist_name) }
  let(:project_name) { "MYPROJECT" }
  let(:project) { MockLogan::Project.new(project_name, todolist) }
  let(:basecamp) { MockLogan::Basecamp.new(project) }

  it 'responds to call' do
    expect(FindBasecampTodoList).to respond_to(:call)
  end

  context '.call returns' do

    it 'nil when does not find todo-list' do
      expect(FindBasecampTodoList.call(project, "INVALID"))
        .to be_nil
    end

    it 'Logan::TodoList when find todo-list' do
      expect(FindBasecampTodoList.call(project, todolist_name).name)
        .to eq(todolist_name)
    end

  end

end
