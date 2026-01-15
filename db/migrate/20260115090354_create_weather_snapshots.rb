# frozen_string_literal: true

# CreateWeatherSnapshots
class CreateWeatherSnapshots < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_snapshots do |t|
      t.string :city
      t.integer :temperature_c
      t.integer :wind_speed

      t.timestamps
    end

    add_index :weather_snapshots, :city, unique: true
  end
end
