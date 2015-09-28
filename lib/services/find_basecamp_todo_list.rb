class FindBasecampTodoList

  def self.call(basecamp_project, todo_list_name)
    self.new(basecamp_project, todo_list_name).call
  end

  attr_accessor :basecamp_project, :todo_list_name

  def initialize(basecamp_project, todo_list_name)
    @basecamp_project = basecamp_project
    @todo_list_name = todo_list_name
  end

  def call
    basecamp_project.todolists.select do |todolists|
      todolists.name.eql?(todo_list_name)
    end.first
  end

end
