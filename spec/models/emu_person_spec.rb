require 'spec_helper'

describe EmuPerson do
  context "with some attributes" do
    let (:person) { FactoryGirl.create(:emu_person) }
    it "is a a valid person" do
      person.should be_valid
    end
  end

  context "#freqency_data" do
    it "reports no data when there are no records" do
      EmuPerson.frequency_data.should == []
    end
    context "when there are some records" do
      before do
        FactoryGirl.create(:emu_person, :count => 1)
        FactoryGirl.create(:emu_person, :count => 2)
        FactoryGirl.create(:emu_person, :count => 12)
        FactoryGirl.create(:emu_person, :count => 60)
      end
      it "reports data with default segment=50" do
        EmuPerson.frequency_data.should == [{segment:0, count:3},
                                            {segment:50, count:1}]
      end

      it "reports alternate levels" do
        EmuPerson.frequency_data(10).should == [{segment:0, count:2},
                                                {segment:10, count:1},
                                                {segment:60, count:1}]

      end
      it "handles nil gracefully" do
        EmuPerson.frequency_data(nil).should ==  [{segment:0, count:3},
                                                  {segment:50, count:1}]

      end
    end
  end


end