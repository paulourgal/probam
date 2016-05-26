require 'logan'
require "story"

describe Story do

  let(:story) { Story.new('723', 'Title', 'Comments') }

  it 'must respond to id' do
    expect(story).to respond_to(:id)
  end

  it 'must respond to title' do
    expect(story).to respond_to(:title)
  end

  it 'must respond to comments' do
    expect(story).to respond_to(:comments)
  end

  context '.create_from_github_issue' do

    let(:valid_github_issue) { { number: "123", title: "title", body: "body" } }
    let(:invalid_github_issue) { { number: nil, title: nil, body: "" } }

    it 'must return nil when github_issue is invalid' do
      expect(Story.create_from_github_issue(invalid_github_issue)).to be_nil
    end

    it 'must return a story when github_issue is valid' do
      expect(Story.create_from_github_issue(valid_github_issue).id)
        .to eq(valid_github_issue[:number])
    end

  end

  context '.create_from_basecamp_todo' do

    class BasecampTodo

      attr_accessor :app_url, :content, :id

      def initialize(app_url, content, id)
        @app_url = app_url
        @content = content
        @id = id
      end

    end

    let(:valid_basecamp_todo) { BasecampTodo.new("URL", "CONTENT", 123) }
    let(:invalid_basecamp_todo) { BasecampTodo.new("", nil, nil) }

    it 'must return nil when basecamp_todo is invalid' do
      expect(Story.create_from_basecamp_todo(invalid_basecamp_todo)).to be_nil
    end

    it 'must return a story when basecamp_todo is valid' do
      expect(Story.create_from_basecamp_todo(valid_basecamp_todo).id)
        .to eq(valid_basecamp_todo.id)
    end

  end

  context "#has_label?(label) when" do
    context "label is bug returns" do
      it "false when there is no BUG label" do
        expect(story.has_label?("bug")).to be_falsey
      end

      it "true when there is BUG label" do
        story = Story.new('723', 'Title', 'Comments', [ { name: "bug" } ])
        expect(story.has_label?("bug")).to be_truthy
      end
    end

    context "label is debt returns" do
      it "false when there is no debt label" do
        expect(story.has_label?("debt")).to be_falsey
      end

      it "true when there is debt label" do
        story = Story.new('723', 'Title', 'Comments', [ { name: "debt" } ])
        expect(story.has_label?("debt")).to be_truthy
      end
    end

    context "label is design returns" do
      it "false when there is no design label" do
        expect(story.has_label?("design")).to be_falsey
      end

      it "true when there is design label" do
        story = Story.new('723', 'Title', 'Comments', [ { name: "design" } ])
        expect(story.has_label?("design")).to be_truthy
      end
    end

    context "label is duplicated returns" do
      it "false when there is no duplicated label" do
        expect(story.has_label?("duplicated")).to be_falsey
      end

      it "true when there is duplicated label" do
        story = Story.new('723', 'Title', 'Comments', [ { name: "duplicated" } ])
        expect(story.has_label?("duplicated")).to be_truthy
      end
    end
  end

  context '#has_comments?' do
    it 'returns false when does not have comments' do
      story = Story.new('123', 'Title', '')
      expect(story.has_comments?).to be_falsey
    end

    it 'returns true when does have comments' do
      expect(story.has_comments?).to be_truthy
    end
  end

  context '#to_basecamp_todo' do
    it 'returns nil when some attribute is missing' do
      story.id = nil
      expect(story.to_basecamp_todo).to be_nil
    end

    it 'returns a Logan::Todo when all attributes are present' do
      expect(story.to_basecamp_todo).to be_a_kind_of(Logan::Todo)
    end
  end

  context '#to_csv' do
    it "returns [''] when some attribute is missing" do
      story.id = nil
      expect(story.to_csv).to eq([''])
    end

    it "returns 'id,title,comment'" do
      expect(story.to_csv).to eq(['723','Title','Comments'])
    end
  end

  context '#to_s' do
    it "returns '' when some attribute is missing" do
      story.id = nil
      expect(story.to_s).to eq("")
    end

    it "returns 'id - title'" do
      expect(story.to_s).to eq("723 - Title\n")
    end
  end

end
