require 'logan'

class FindBasecampProject

  def self.call(basecamp, project_name)
    self.new(basecamp, project_name).call
  end

  attr_accessor :basecamp, :project_name

  def initialize(basecamp, project_name)
    @basecamp = basecamp
    @project_name = project_name
  end

  def call
    basecamp.projects.select { |project| project.name.eql?(project_name) }.first
  end

end
