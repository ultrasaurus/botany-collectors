require 'spec_helper'

describe "records/index" do
  before(:each) do
    assign(:records, [
      stub_model(Record,
        :edan_id => "Edan",
        :image_uri => "Image Uri",
        :description => "MyText",
        :type => "Type"
      ),
      stub_model(Record,
        :edan_id => "Edan",
        :image_uri => "Image Uri",
        :description => "MyText",
        :type => "Type"
      )
    ])
  end

  it "renders a list of records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Edan".to_s, :count => 2
    assert_select "tr>td", :text => "Image Uri".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
