class CreateCard < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.belongs_to :deck_info, index: true

      t.integer :suit # 0-3
      t.integer :card_number # 2-14
      t.string :image_url
      t.string :name
      t.string :action1
      t.string :action2
    end
  end
end
