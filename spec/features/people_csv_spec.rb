require 'spec_helper'

describe 'generate csv' do
  context 'all people' do
    before do
      FactoryGirl.create(:emu_person, :count => 1)
      FactoryGirl.create(:emu_person, :count => 22)
      FactoryGirl.create(:emu_person, :count => 35)
    end
    it 'exports correct format' do
      visit emu_people_path(format: 'csv')
      expect(page.status_code).to eq(200)
      expect(page.body).to include("count,irn,full_name,brief_name")

      emu_person = EmuPerson.last
      data = [emu_person.count, emu_person.irn, emu_person.full_name, '"' + emu_person.brief_name + '"']
      row = data.join(',')
      expect(page.body).to include(row)
    end
  end
  context 'top N% of people' do
    before do
      20.times do |num|
        FactoryGirl.create(:emu_person, :count => num)
      end
    end
    it 'exports top 10% (2 of 20)' do
      visit emu_people_path(format: 'csv', ntile:10)
      expect(page.status_code).to eq(200)
      expect(page.body).to include("count,irn,full_name,brief_name")
      expect(page.body.lines.count).to eq(3)

      top_result = EmuPerson.order(count: :desc).limit(2)
      emu_person = top_result[0]
      data = [emu_person.count, emu_person.irn, emu_person.full_name, '"' + emu_person.brief_name + '"']
      row = data.join(',')
      expect(page.body).to include(row)
    end
  end

end
