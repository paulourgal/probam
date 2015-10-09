#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require 'csv'
require_relative "services/get_issues_from_github"
require_relative "story"

# load configuration file

config = YAML.load_file("config.yml")

# reading configurations for github

github_config = config["github"]

github_access_token = github_config["access_token"]

github_project = github_config["projects"]["ancora"]
github_project_repo = github_project["repo"]
github_project_milestone = github_project["milestone"]["sprint_ten"]

state = ARGV[0] || "open"

puts "\n#{state.upcase} issues\n\n"

# get open issues from github

issues = GetIssuesFromGithub.call(
  github_access_token, github_project_repo, github_project_milestone, state
)

# creating string of issues

string_of_issues = ""
total_velocity = 0

issues.each do |issue|
  story = Story.create_from_github_issue(issue)
  total_velocity += story.velocity.to_i
  string_of_issues += "[ ] " + story.to_s + "\n\n"
end

puts string_of_issues
puts "Velocity #{state.upcase}: #{total_velocity}\n"

puts "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"

state = "closed"

puts "\n#{state.upcase} issues\n\n"

# get closed issues from github

issues = GetIssuesFromGithub.call(
  github_access_token, github_project_repo, github_project_milestone, state
)

# creating string of issues

string_of_issues = ""
total_velocity = 0

issues.each do |issue|
  story = Story.create_from_github_issue(issue)
  total_velocity += story.velocity.to_i
  string_of_issues += "[ ] " + story.to_s + "\n\n"
end

puts string_of_issues
puts "Velocity #{state.upcase}: #{total_velocity}"

