# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when "development"
	mp = MemoryPalace.new(name: 'default')
	mp.skip_name_validation = true
	(1..11).each do |default_num|
		mp.images.attach(io: File.open(Rails.root.join("storage", "mem_palace_default", "default#{default_num}.jpg")), filename: "default1.jpg", content_type: "image/jpg")
	end
	mp.save
when "production"
end
