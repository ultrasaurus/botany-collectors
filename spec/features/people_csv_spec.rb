require 'spec_helper'

describe 'generate csv' do
  before do
    FactoryGirl.create(:emu_person, :count => 1)
    FactoryGirl.create(:emu_person, :count => 22)
    FactoryGirl.create(:emu_person, :count => 35)
  end
  it 'can export list of people' do
    visit emu_people_path(format: 'csv')
    expect(page.status_code).to eq(200)
    expect(page.body).to include("count,irn,full_name,brief_name")

    emu_person = EmuPerson.last
    data = [emu_person.count, emu_person.irn, emu_person.full_name, '"' + emu_person.brief_name + '"']
    row = data.join(',')
    expect(page.body).to include(row)
  end

end
