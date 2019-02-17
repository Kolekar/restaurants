class CreateRestaurantsTables < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants_tables do |t|
      t.string :name
      t.integer :minimum
      t.integer :maximum
      t.references :restaurant

      t.timestamps
    end
  end
end
