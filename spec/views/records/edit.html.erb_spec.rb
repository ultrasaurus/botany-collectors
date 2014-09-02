require 'spec_helper'

describe "records/edit" do
  before(:each) do
    @record = assign(:record, stub_model(Record,
      :edan_id => "MyString",
      :image_uri => "MyString",
      :description => "MyText",
      :type => ""
    ))
  end

  it "renders the edit record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", record_path(@record), "post" do
      assert_select "input#record_edan_id[name=?]", "record[edan_id]"
      assert_select "input#record_image_uri[name=?]", "record[image_uri]"
      assert_select "textarea#record_description[name=?]", "record[description]"
      assert_select "input#record_type[name=?]", "record[type]"
    end
  end
end
