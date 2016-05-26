#!/usr/bin/env ruby

require "rubygems"
require 'yaml'
require 'csv'
require_relative "services/github/authenticate_on_github"
require_relative "services/github/find_milestone"
require_relative "services/github/get_issues_from_github"
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


# creating csv with issues

CSV.open("github_to_csv.csv", 'wb', col_sep: ",") do |csv|
  csv << ["ID", "Estória", "Comentários", "Prioridade"]
  issues.each do |issue|
    story = Story.create_from_github_issue(issue)
    csv << story.to_csv
  end
end

