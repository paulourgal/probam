module MockOctokit
  class Issue
    attr_accessor :title

    def initialize(title="TITLE")
      @title = title
    end
  end

  class Milestone
    attr_accessor :number, :title

    def initialize(title="TITLE", number=1)
      @title = title
      @number = number
    end

    def open_issues
      5
    end

    def closed_issues
      5
    end
  end

  class OctokitClient
    attr_accessor :issues, :milestones

    def initialize(milestone=nil, issue=nil)
      @milestones = [milestone]
      @issues = [issue]
    end

    def create_milestone(repo_name, milestone_name)
      milestone = @milestones.first
      milestone.title = milestone_name
      milestone
    end

    def create_issue(repo_name, issue_name, issue_body)
      issue = @issues.first
      issue.title = issue_name
      issue
    end

    def issues(repo_name, opst={})
      @issues
    end

    def list_milestones(repo_name)
      @milestones
    end

    def list_issues(repo_name)
      @issues
    end
  end
end
