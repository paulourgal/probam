require 'logan'
require 'services/base_service'

class FindBasecampProject < BaseService

  attr_accessor :basecamp, :project_name

  def initialize(basecamp, project_name)
    @basecamp = basecamp
    @project_name = project_name
  end

  def call
    basecamp.projects.find { |project| project.name.eql?(project_name) }
  end

end
