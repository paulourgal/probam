require 'services/base_service'

class GetTodosFromBasecamp < BaseService

  attr_accessor :basecamp_todo_list

  def initialize(basecamp_todo_list)
    @basecamp_todo_list = basecamp_todo_list
  end

  def call
    basecamp_todo_list.todos
  end

end
