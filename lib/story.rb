require 'logan'

class Story

  def self.create_from_github_issue(github_issue)
    id = github_issue[:number]
    title = github_issue[:title]
    comments = github_issue[:body]
    return nil if id.nil? || title.nil?
    self.new(id, title, comments)
  end

  def self.create_from_basecamp_todo(basecamp_todo)
    id = basecamp_todo.id
    title = basecamp_todo.content
    comments = basecamp_todo.app_url
    return nil if id.nil? || title.nil?
    self.new(id, title, comments)
  end

  attr_accessor :id, :comments, :title

  def initialize(id, title, comments)
    @id = id
    @title = title
    @comments = comments
  end

  def has_comments?
    (!comments.nil? && comments.strip != "")
  end

  def to_basecamp_todo
    return nil if id.nil? || title.nil?
    todo = Logan::Todo.new(id: id, content: "#{id} - #{title}")
    todo
  end

  def to_csv
    return [''] if id.nil? || title.nil?
    [id,title,comments]
  end

  def to_s
    return "" if id.nil? || title.nil?
    "#{id} - #{title}\n#{comments}\n\n"
  end

end
