class CreateBestTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :best_times do |t|
      t.belongs_to :user, index: true

      t.integer :seconds
      t.integer :mistakes
      t.integer :difficulty # easy: 1, medium: 2, hard: 3

      t.timestamps
    end
  end
end
