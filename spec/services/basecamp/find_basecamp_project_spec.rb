require 'services/basecamp/find_basecamp_project'
require_relative "../../mockings/logan"

describe FindBasecampProject do

  let(:project_name) { "MYPROJECT" }
  let(:project) { MockLogan::Project.new(project_name) }
  let(:basecamp) { MockLogan::Basecamp.new(project) }

  it 'responds to call' do
    expect(FindBasecampProject).to respond_to(:call)
  end

  context '.call returns' do

    it 'nil when does not find project' do
      expect(FindBasecampProject.call(basecamp, "INVALID")).to be_nil
    end

    it 'Logan::Project when find project' do
      expect(FindBasecampProject.call(basecamp, project_name).name)
        .to eq(project_name)
    end

  end

end
