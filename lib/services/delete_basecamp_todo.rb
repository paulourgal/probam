require 'logan'

class DeleteBasecampTodo

  def self.call(todo_list, todo_id)
    self.new(todo_list, todo_id).call
  end

  attr_accessor :todo_list, :todo_id, :todo

  def initialize(todo_list, todo_id)
    @todo_list = todo_list
    @todo_id = todo_id
  end

  def call
    @todo = find_todo
    return nil if todo.nil?
    todo_list.delete_todo(todo)
  end

  private

  def find_todo
    todo_list.todos.select do |todo|
      todo.content.include?(todo_id)
    end.first
  end

end
