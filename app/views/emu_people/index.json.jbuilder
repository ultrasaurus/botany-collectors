json.array!(@emu_people) do |emu_person|
  json.extract! emu_person, :id, :count, :irn, :full_name, :brief_name, :birth_date, :death_date, :bio_location, :start_date, :end_date
  json.url emu_person_url(emu_person, format: :json)
end
