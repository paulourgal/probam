require 'logan'

class Story

  def self.create_from_github_issue(github_issue)
    id = github_issue[:number]
    title = github_issue[:title]
    return nil if id.nil? || title.nil?
    comments = github_issue[:body]
    labels = github_issue[:labels]
    self.new(id, title, comments, labels)
  end

  def self.create_from_basecamp_todo(basecamp_todo)
    id = basecamp_todo.id
    title = basecamp_todo.content
    return nil if id.nil? || title.nil?
    comments = basecamp_todo.app_url
    self.new(id, title, comments)
  end

  attr_accessor :id, :comments, :labels, :title

  def initialize(id, title, comments, labels=nil)
    @id = id
    @title = title
    @comments = comments
    @labels = labels
  end

  def has_label?(label)
    @labels.any? { |l| l[:name] == label } unless @labels.nil?
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
    "#{id} - #{title}\n"
  end

end
