#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require 'csv'
require_relative "services/get_issues_from_github"
require_relative "story"

# privates

def has_label?(labels, label)
  labels.any? { |l| l[:name] == label } unless labels.nil?
end

# all | open | closed
state = ARGV[0] || "open"

# projetc_name - default is caiena-survey-web

projetc_name = ARGV[1] || "caiena-survey-web"

# load configuration file

config = YAML.load_file("config.yml")

# reading configurations for github

github_config = config["github"]

github_access_token = github_config["access_token"]

github_project = github_config["projects"][projetc_name]
github_project_repo = github_project["repo"]
github_project_milestone = github_project["milestone"]["current"]

# get issues from github

issues = GetIssuesFromGithub.call(
  github_access_token, github_project_repo, github_project_milestone, state
)


# creating string of issues

string_of_issues = ""

issues.each do |issue|
  if issue[:number] >= 73
    labels =
    story = Story.create_from_github_issue(issue)
    string_of_issues += "[BUG] " if story.has_label?("bug")
    string_of_issues += "[DEBT] " if story.has_label?("debt")
    string_of_issues += "[DESIGN] " if story.has_label?("design")
    string_of_issues += "[ANDROID] " if has_label?(story.labels, "android")
    string_of_issues += story.to_s + "\n" + story.comments + "\n\n" unless story.has_label?("duplicated")
  end
end

puts string_of_issues



