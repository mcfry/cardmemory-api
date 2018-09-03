class CreateMemoryPalaces < ActiveRecord::Migration[5.1]
  def change
    create_table :memory_palaces do |t|
		t.belongs_to :user, index: true
		t.string :name, required: true

		t.timestamps
    end
  end
end
