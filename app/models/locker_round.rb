class LockerRound < ActiveRecord::Base
	has_many :ballots, class_name: "LockerBallot"
	has_many :allocations, class_name: "LockerAllocation"

	enum kind: [:ballot, :swap]
	scope :active_at, -> (time) { where('start <= ? and end > ?', time, time) }

	def name
		"#{acad_year} (#{label})"
	end
end
