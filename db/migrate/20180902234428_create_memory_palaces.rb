class CreateMemoryPalaces < ActiveRecord::Migration[5.1]
  def change
    create_table :memory_palaces do |t|
		t.belongs_to :user, index: true
		t.string :name, required: true

		# TODO: new model
		# number of groups in each image, max of 52/3 palace images
		# each group is an array of positions
		t.text :groups_to_image_array, default: (0..51).step(3).inject([]){|arr,step| arr << []; arr}.to_yaml

		t.timestamps
    end
  end
end
