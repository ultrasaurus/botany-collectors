require 'spec_helper'

describe "records/new" do
  before(:each) do
    assign(:record, stub_model(Record,
      :edan_id => "MyString",
      :image_uri => "MyString",
      :description => "MyText",
      :type => ""
    ).as_new_record)
  end

  it "renders new record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", records_path, "post" do
      assert_select "input#record_edan_id[name=?]", "record[edan_id]"
      assert_select "input#record_image_uri[name=?]", "record[image_uri]"
      assert_select "textarea#record_description[name=?]", "record[description]"
      assert_select "input#record_type[name=?]", "record[type]"
    end
  end
end
