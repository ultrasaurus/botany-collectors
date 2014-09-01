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
  context "#frequency_by_percent" do
    it "reports no data when there are no records" do
      EmuPerson.frequency_by_percent.should == []
    end
    context "when there are some records" do
      before do
        100.times do |num|
          FactoryGirl.create(:emu_person, :count => num)
        end
      end
      def generate_expected(percentile)
        expected = []
        segments = 100 / percentile
        (1..segments).each do |num|
          start = (num-1)*percentile
          sum = (start..(start+percentile-1)).inject(:+)
          sum = sum.to_f
          num = num.to_f
          start = start.to_f
          max = start + percentile - 1
          expected << HashWithIndifferentAccess.new({ntile:num, perc:num*percentile.to_f, avg:(sum/percentile), max:max, min:start, total:sum})
        end
        expected
      end
      let(:expected_10) { generate_expected(10) }
      let(:expected_20) { generate_expected(20) }

      it "reports data with default percentile=10" do
        EmuPerson.frequency_by_percent.should == expected_10
      end

      it "handles nil gracefully" do
        EmuPerson.frequency_by_percent(nil).should == expected_10
      end

      it "reports data with percentile=20" do
        EmuPerson.frequency_by_percent(20).should == expected_20
      end

    end
  end


end
