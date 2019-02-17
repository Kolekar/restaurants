class CreateRestaurantsShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants_shifts do |t|
      t.string :title
      t.time :start_time
      t.time :end_time
      t.references :restaurant

      t.timestamps
    end
  end
end
