class Record < ActiveRecord::Base
  belongs_to :emu_person
  validates_presence_of :edan_id
end
