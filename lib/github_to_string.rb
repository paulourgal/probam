#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require_relative "services/github/authenticate_on_github"
require_relative "services/github/find_milestone"
require_relative "services/github/get_issues_from_github"
require_relative "story"

# all | open | closed
state = ARGV[0] || "open"

# projetc_name - default is caiena-survey-web

projetc_name = ARGV[1] || "caiena-survey-web"

# load configuration file

config = YAML.load_file("config.yml")

# reading configurations for github

github_config = config["github"]

github_access_token = github_config["access_token"]
octokit_client = AuthenticateOnGithub.call(github_access_token)

github_project = github_config["projects"][projetc_name]
github_project_repo = github_project["repo"]
github_project_milestone = github_project["milestone"]["current"]
milestone = FindMilestone.call(github_project_milestone, octokit_client, github_project_repo)

# get issues from github

issues = GetIssuesFromGithub.call(milestone, octokit_client, github_project_repo, state)


# creating string of issues

string_of_issues = ""

issues.each do |issue|
  story = Story.create_from_github_issue(issue)
  string_of_issues += "[BUG] " if story.has_label?("bug")
  string_of_issues += "[DEBT] " if story.has_label?("debt")
  string_of_issues += "[DESIGN] " if story.has_label?("design")
  string_of_issues += "[ANDROID] " if story.has_label?("android")
  string_of_issues += story.to_s + "\n" + story.comments + "\n\n" unless story.has_label?("duplicated")
end

puts string_of_issues



