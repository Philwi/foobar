class CreateSurflineConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :surfline_conditions do |t|
      t.date :forecast_day, required: true
      t.float :rating
      t.float :min_height
      t.float :max_height
      t.belongs_to :surfline_spot

      t.timestamps
    end
  end
end
