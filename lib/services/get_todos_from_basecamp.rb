class GetTodosFromBasecamp

  def self.call(basecamp_todo_list)
    self.new(basecamp_todo_list).call
  end

  attr_accessor :basecamp_todo_list

  def initialize(basecamp_todo_list)
    @basecamp_todo_list = basecamp_todo_list
  end

  def call
    basecamp_todo_list.todos
  end

end
