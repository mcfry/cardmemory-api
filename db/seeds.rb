case Rails.env
when "development"
	# Create Default User
	user = User.create(username: 'default', email: 'admincm@cardmem.com', password: 'password', password_confirmation: 'password')
	if user
		puts 'Created Default User'
		puts 'Created Default Memory Palace and Linked Images' # user callback
	end

	di = DeckInfo.create(deck_type: 'light', red: 'Women', black: 'Men', hearts: 'Good', diamonds: 'Evil', clubs: 'Good', spades: 'Evil')
	deck = Deck.create(user_id: user.id, deck_info_id: di.id)

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 13,
		image_url: "https://images-na.ssl-images-amazon.com/images/I/41S2WpVxqNL.jpg",
		name: "b",
		action1: "b",
		action2: "https://images-na.ssl-images-amazon.com/images/I/41S2WpVxqNL.jpg",
		action2_tx: 111.86666870117188,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 14,
		image_url: "data:image/png;base64,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",
		name: "a",
		action1: "a",
		action2: "data:image/png;base64,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",
		action2_tx: 91.0,
		action2_ty: -170.0
	)
puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 12,
		image_url: "https://www.shareicon.net/download/2016/10/20/846459_blue_512x512.png",
		name: "c",
		action1: "c",
		action2: "https://www.shareicon.net/download/2016/10/20/846459_blue_512x512.png",
		action2_tx: 80.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 10,
		image_url: "https://cdn.pixabay.com/photo/2017/04/20/17/09/letter-e-2246323_960_720.png",
		name: "e",
		action1: "e",
		action2: "https://cdn.pixabay.com/photo/2017/04/20/17/09/letter-e-2246323_960_720.png",
		action2_tx: 44.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 11,
		image_url: "http://rcreativeapps.info/wp-content/uploads/2016/08/letra-d.gif",
		name: "d",
		action1: "d",
		action2: "http://rcreativeapps.info/wp-content/uploads/2016/08/letra-d.gif",
		action2_tx: -8.216659545898438,
		action2_ty: 0.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 6,
		image_url: "http://www.pngall.com/wp-content/uploads/2/I-Letter-PNG-Clipart.png",
		name: "i",
		action1: "i",
		action2: "http://www.pngall.com/wp-content/uploads/2/I-Letter-PNG-Clipart.png",
		action2_tx: 80.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 7,
		image_url: "https://cdn.pixabay.com/photo/2017/02/18/14/10/letters-2077266_960_720.png",
		name: "h",
		action1: "h",
		action2: "https://cdn.pixabay.com/photo/2017/02/18/14/10/letters-2077266_960_720.png",
		action2_tx: 81.41667175292969,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 8,
		image_url: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/626f7f20-56da-4a6c-9996-50364c8b9ae2/d7xy48g-c0a94f7a-ca10-4783-9ecb-f46a9b4b4e2a.png",
		name: "g",
		action1: "g",
		action2: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/626f7f20-56da-4a6c-9996-50364c8b9ae2/d7xy48g-c0a94f7a-ca10-4783-9ecb-f46a9b4b4e2a.png",
		action2_tx: 80.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 9,
		image_url: "http://origin.lcv.org/wp-content/uploads/2018/01/f-grade.png",
		name: "f",
		action1: "f",
		action2: "http://origin.lcv.org/wp-content/uploads/2018/01/f-grade.png",
		action2_tx: 71.68333435058594,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 2,
		image_url: "http://pluspng.com/img-png/letter-m-hd-png-capital-letter-m-icon-110699-512.png",
		name: "m",
		action1: "m",
		action2: "http://pluspng.com/img-png/letter-m-hd-png-capital-letter-m-icon-110699-512.png",
		action2_tx: 80.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 3,
		image_url: "https://pngimg.com/uploads/letter_L/letter_L_PNG107.png",
		name: "l",
		action1: "l",
		action2: "https://pngimg.com/uploads/letter_L/letter_L_PNG107.png",
		action2_tx: 80.0,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 4,
		image_url: "https://cdn.pixabay.com/photo/2017/02/18/14/02/letters-2077237_960_720.png",
		name: "k",
		action1: "k",
		action2: "https://cdn.pixabay.com/photo/2017/02/18/14/02/letters-2077237_960_720.png",
		action2_tx: 81.41667175292969,
		action2_ty: -170.0
	)
	puts 'Created Card'

	Card.create(
		deck_id: deck.id,
		suit: 1,
		card_number: 5,
		image_url: "https://cdn.pixabay.com/photo/2017/02/18/14/02/letters-2077235_960_720.png",
		name: "j",
		action1: "j",
		action2: "https://cdn.pixabay.com/photo/2017/02/18/14/02/letters-2077235_960_720.png",
		action2_tx: 81.41667175292969,
		action2_ty: -170.0
	)
	puts 'Created Card'
when "production"
end
