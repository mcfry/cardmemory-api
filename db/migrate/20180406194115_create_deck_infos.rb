class CreateDeckInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_infos do |t|
    	t.string :deck_type, null: false
    	t.string :red
    	t.string :black
    	t.string :hearts
    	t.string :diamonds
    	t.string :clubs
    	t.string :spades

		t.timestamps
    end
  end
end
