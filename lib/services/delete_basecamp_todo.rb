require 'logan'

class DeleteBasecampTodo

  def self.call(basecamp_todo_list, todo_id)
    self.new(basecamp_todo_list, todo_id).call
  end

  attr_accessor :basecamp_todo_list, :todo_id, :todo

  def initialize(basecamp_todo_list, todo_id)
    @basecamp_todo_list = basecamp_todo_list
    @todo_id = todo_id
  end

  def call
    @todo = find_todo
    return nil if todo.nil?
    basecamp_todo_list.delete_todo(todo)
  end

  private

  def find_todo
    basecamp_todo_list.todos.select do |todo|
      todo.content.include?(todo_id)
    end.first
  end

end
