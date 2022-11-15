class CreateSurflineSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :surfline_spots do |t|
      t.belongs_to :spot, foreign_key: true, index: true
      t.float :lat
      t.float :lon
      t.string :name
      t.string :surfline_id, null: false
      t.timestamps
    end

    add_index :surfline_spots, :surfline_id, unique: true
  end
end
