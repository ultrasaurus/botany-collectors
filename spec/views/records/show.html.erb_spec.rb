require 'spec_helper'

describe "records/show" do
  before(:each) do
    @record = assign(:record, stub_model(Record,
      :edan_id => "Edan",
      :image_uri => "Image Uri",
      :description => "MyText",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Edan/)
    rendered.should match(/Image Uri/)
    rendered.should match(/MyText/)
    rendered.should match(/Type/)
  end
end
