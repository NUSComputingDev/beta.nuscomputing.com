class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable

  has_many :requests, class_name: "ItemRequest", dependent: :destroy
  has_many :item_transactions, class_name: "ItemTransaction", through: :requests, dependent: :destroy
  has_many :locker_allocations, dependent: :destroy
  has_many :lockers, through: :locker_allocations

  def current_locker
		locker_allocations.active.first.locker if locker_allocations.active.first
	end

  def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			# Adding extra information here from the hash returned by Omniauth:IVLE
      logger.fatal('TROLOLOLOLOLOL I\'M IN FROM OMNIAUTH HAHAHA')
			user.faculty = auth.extra['profile']['Faculty']
      user.name = auth.extra['profile']['Name']
			user.email = auth.info['email']
      logger.fatal(auth.info.pretty_print_inspect)
      #user.first_major =
		end
	end
end
