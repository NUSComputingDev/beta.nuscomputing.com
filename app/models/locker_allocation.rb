class LockerAllocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :locker
  belongs_to :round, class_name: "LockerRound", foreign_key: "locker_round_id"

  enum status: [:active, :archived]
  validates :user, :locker, :round, presence: true
  validates_uniqueness_of :user, conditions: -> { where.not(status: 1) }
end
