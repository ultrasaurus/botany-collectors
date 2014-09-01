# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :irn do |n|
    999 + n
  end

  factory :emu_person do
    # local vars
    first_name = Faker::Name.first_name
    middle_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    # attributes
    irn
    count Kernel.rand(10)
    full_name "#{first_name} #{last_name}"
    brief_name "#{last_name}, #{first_name[0]}. #{middle_name[0]}."
    birth_date "1812"
    death_date "1904"
  end
end
