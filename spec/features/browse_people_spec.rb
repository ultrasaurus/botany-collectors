require 'spec_helper'

describe 'browse people' do
  it 'can see list of people' do
    visit emu_people_path
    expect(page.status_code).to eq(200)
  end

  it 'can see person page' do
    person = FactoryGirl.create(:emu_person, :count => 1)
    visit emu_person_path(person.id)
    expect(page.status_code).to eq(200)
  end
end
