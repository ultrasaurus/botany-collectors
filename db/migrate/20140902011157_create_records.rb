class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :edan_id
      t.string :image_uri
      t.text :description
      t.string :type
      t.references :emu_person

      t.timestamps
    end
  end
end
