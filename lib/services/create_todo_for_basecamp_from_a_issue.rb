require 'logan'
require_relative "../story"

class CreateTodoForBasecampFromAIssue

  def self.call(github_issue, todo_list)
    self.new(github_issue, todo_list).call
  end

  attr_accessor :github_issue, :todo_list, :story

  def initialize(github_issue, todo_list)
    @github_issue = github_issue
    @todo_list = todo_list
    @story = Story.create_from_github_issue(github_issue)
  end

  def call
    return nil if story.nil? || already_exist?
    todo = todo_list.create_todo(story.to_basecamp_todo)
    if story.has_comments?
      comment = Logan::Comment.new(content: story.comments)
      todo.create_comment(comment)
    end
    story
  end

  private

  def already_exist?
    todo_list.todos.any? { |todo| todo.content.include?(story.id.to_s) }
  end

end
