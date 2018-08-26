class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
    	t.belongs_to :deck_info, index: true
    	t.belongs_to :user, index: true

    	t.timestamps
    end
  end
end
