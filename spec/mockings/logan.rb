module MockLogan
  class ToDo
    attr_accessor :content

    def initialize(content="")
      @content = content
    end

    def create_comment(comment)
      nil
    end
  end

  class ToDoList
    attr_accessor :name, :todos

    def initialize(name="MYTODOLIST", todo=nil)
      @name = name
      @todos = [todo]
    end

    def create_todo(todo_content)
      todo = MockLogan::ToDo.new
      @todos << todo
      todo
    end

    def delete_todo(todo)
      nil
    end
  end

  class Project
    attr_accessor :name, :todolists

    def initialize(name, todolist=nil)
      @name = name
      @todolists = [todolist]
    end
  end

  class Basecamp
    attr_accessor :projects

    def initialize(project)
      @projects = [project]
    end
  end
end
