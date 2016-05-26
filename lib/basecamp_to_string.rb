#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require 'logan'
require_relative 'services/basecamp/find_basecamp_project'
require_relative "services/basecamp/authenticate_on_basecamp"
require_relative "services/basecamp/find_basecamp_todo_list"
require_relative "story"

# projetc_name - default is saber

projetc_name = ARGV[0] || "saber"

# load configuration file

config = YAML.load_file("config.yml")

# reading configurations for basecamp

basecamp_config = config["basecamp"]

# user
basecamp_id = basecamp_config["id"]
basecamp_username = basecamp_config["username"]
basecamp_password = basecamp_config["password"]
basecamp_user = AuthenticateOnBasecamp.call(
                           basecamp_id, basecamp_username, basecamp_password
                         )

# project
basecamp_project = basecamp_config["projects"][projetc_name]
basecamp_project_name = basecamp_project["name"]
project = FindBasecampProject.call(basecamp_user, basecamp_project_name)


# todo_list
basecamp_project_todo_list = basecamp_project["todolist"]
todo_list = FindBasecampTodoList.call(project, basecamp_project_todo_list)

# get todos from basecamp
todos = todo_list.todos || []


# creating string of todos

string_of_todos = ""

todos.each do |todo|
  story = Story.create_from_basecamp_todo(todo)
  string_of_todos += story.to_s + "\n"
end

puts string_of_todos

