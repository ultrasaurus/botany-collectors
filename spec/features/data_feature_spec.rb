require 'spec_helper'

describe 'data' do
  it 'can get frequency data' do
    visit '/emu_people/frequency_data'
    expect(page).to have_content('[]')
  end

  it 'can get frequency data' do
    FactoryGirl.create(:emu_person, :count => 1)
    FactoryGirl.create(:emu_person, :count => 2)
    FactoryGirl.create(:emu_person, :count => 12)

    visit '/emu_people/frequency_data?segment=10'
    expect(page).to have_content('[{"segment":0,"count":2},{"segment":10,"count":1}]')
  end

  it 'can get frequency data' do
    visit '/emu_people/frequency_by_percent'
    expect(page).to have_content('[]')
  end

end
