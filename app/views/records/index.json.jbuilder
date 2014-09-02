json.array!(@records) do |record|
  json.extract! record, :id, :edan_id, :image_uri, :description, :type
  json.url record_url(record, format: :json)
end
