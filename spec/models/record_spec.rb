require 'spec_helper'

describe Record do
  it { should validate_presence_of :edan_id }
  it { should belong_to :emu_person }

end
