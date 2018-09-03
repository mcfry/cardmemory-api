class CreateCard < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.belongs_to :deck, index: true

      t.integer :suit # 0-3
      t.integer :card_number # 2-14
      t.string :image_url
      t.float :image_tx
      t.float :image_ty
      t.float :image_h
      t.float :image_w
      t.string :name
      t.string :action1
      t.string :action2
      t.float :action2_tx
      t.float :action2_ty
      t.float :action2_h
      t.float :action2_w
    end
  end
end
