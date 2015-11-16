require 'logan'

class Story
  STATUSES = ["[wip:rev]","[wip:rev]","[wip:qa]"]

  def self.create_from_github_issue(github_issue)
    id = github_issue[:number]
    title = github_issue[:title]
    velocity = title.nil? || title[/[0-9]+/].nil? ? 0 : title[/[0-9]+/]
    comments = github_issue[:body]
    assignee = github_issue[:assignee] if github_issue[:assignee]
    labels = github_issue[:labels] if github_issue[:labels]
    return nil if id.nil? || title.nil?
    self.new(id, title, comments, assignee, labels, velocity)
  end

  attr_accessor :id, :comments, :title, :assignee, :labels, :velocity

  def initialize(id, title, comments, assignee=nil, labels=nil, velocity=nil)
    @id = id
    @title = title
    @comments = comments
    @assignee = assignee
    @labels = labels
    @velocity = velocity
  end

  def current_status
    return "dev" if labels_to_s["dev"]
    return "rev" if labels_to_s["rev"]
    return "qa" if labels_to_s["qa"]
    ""
  end

  def labels_to_s
    return "" unless labels
    labels_s = ""
    labels.each do |label|
      labels_s << "[#{label.name}]"
    end
    labels_s
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
    return "" unless id && title
    s = "#{id} - #{title}"
    s << " #{labels_to_s}" unless labels_to_s.empty?
    s << " - #{assignee.login}" unless assignee.nil?
    s
  end
end
