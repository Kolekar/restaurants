class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :guest
      t.datetime :reservation_time
      t.references :restaurants_table
      t.integer :guest_count

      t.timestamps
    end
  end
end
