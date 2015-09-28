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
