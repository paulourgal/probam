#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require_relative "services/github/authenticate_on_github"
require_relative "services/github/get_issues_from_github"
require_relative "services/basecamp/authenticate_on_basecamp"
require_relative "services/basecamp/find_basecamp_project"
require_relative "services/basecamp/find_basecamp_todo_list"
require_relative "services/basecamp/create_todo_for_basecamp_from_a_issue"
require_relative "story"

state = ARGV[0] || "open"

# load configuration file

config = YAML.load_file("config.yml")

# reading configurations for github

github_config = config["github"]

github_access_token = github_config["access_token"]
octokit_client = AuthenticateOnGithub.call(github_access_token)

github_project = github_config["projects"]["ancora"]
github_project_repo = github_project["repo"]
github_project_milestone = github_project["milestone"]["backlog"]
milestone = FindMilestone.call(github_project_milestone, octokit_client, github_project_repo)

# get issues from github

issues = GetIssuesFromGithub.call(milestone, octokit_client, github_project_repo, state)

# reading configurations for basecamp

basecamp_config = config["basecamp"]

basecamp_id = basecamp_config["id"]
basecamp_username = basecamp_config["username"]
basecamp_password = basecamp_config["password"]

basecamp_project = basecamp_config["projects"]["ancora"]
basecamp_project_name = basecamp_project["name"]
basecamp_project_todolist = basecamp_project["todolist"]

# authenticating on basecamp

basecamp = AuthenticateOnBasecamp.call(basecamp_id, basecamp_username, basecamp_password)

basecamp_project = FindBasecampProject.call(basecamp, basecamp_project_name)

basecamp_todolist = FindBasecampTodoList.call(basecamp_project, basecamp_project_todolist)

# adding issues to basecamp

issues.each do |issue|
  story = CreateTodoForBasecampFromAIssue.call(issue, basecamp_todolist)
  puts story.to_s unless story.nil?
end

