class Mc::Locker::LockersController < Mc::BaseController
	before_action :set_locker, only: [:show, :edit, :update, :destroy]
	def index
		@lockers_by_location = ::Locker.lockers_by_location
	end

	def new
		@locker = ::Locker.new
	end

	def show
	end

	def create
		# TODO: implement creating
	end

	private
	def set_locker
		@locker = ::Locker.find(params[:id])
	end
end
