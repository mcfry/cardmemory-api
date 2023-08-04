class BestTime < ApplicationRecord

	# Other
	enum difficulty: {easy: 0, medium: 1, hard: 2, very_hard: 3}

	# Relations
	belongs_to :user, optional: true

	# Validations
	validate :validate_quota, on: :create

	# Number of cards
	LIMIT = 15

	# fix for 5 each diffic
	def validate_quota
		return unless self.user
		if self.user.best_times.count >= LIMIT
			errors.add(:base, :exceeded_quota)
		end
	end

end
