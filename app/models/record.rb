class Record < ActiveRecord::Base
  SOURCE_URL = "http://temp-sample-data.herokuapp.com/objects/"

  belongs_to :emu_person
  validates_presence_of :edan_id

  def object_url
    SOURCE_URL + edan_id
  end
end
