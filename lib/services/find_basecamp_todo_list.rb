class String
  BLANK_RE = /\A[[:space:]]*\z/

  # A string is blank if it's empty or contains whitespaces only:
  #
  #   ''.blank?       # => true
  #   '   '.blank?    # => true
  #   "\t\n\r".blank? # => true
  #   ' blah '.blank? # => false
  #
  # Unicode whitespace is supported:
  #
  #   "\u00a0".blank? # => true
  #
  # @return [true, false]
  def blank?
    BLANK_RE === self
  end
end

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
