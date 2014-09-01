class CreateEmuPeople < ActiveRecord::Migration
  def change
    create_table :emu_people do |t|
      t.integer :count
      t.integer :irn
      t.string :full_name
      t.string :brief_name
      t.string :birth_date
      t.string :death_date
      t.string :bio_location
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
