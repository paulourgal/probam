require 'logan'
require_relative '../base_service'

class DeleteBasecampTodo < BaseService

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
