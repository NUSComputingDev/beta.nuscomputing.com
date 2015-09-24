class LockerBallotsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_ballot, only: [:update, :destroy]
	def create
		@ballot = LockerBallot.new ballot_params	
		@ballot.user_id = current_user.id

		respond_to do |format|
			if DateTime.now <= @ballot.round.end && @ballot.save
				format.html { redirect_to locker_path, notice: "Ballot Application submitted!" }
				format.json { render json: @ballot, status: :created, location: @ballot }
			else
				format.html { redirect_to :back }
				format.json { render json: @ballot.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		if @ballot.update(ballot_params)
			redirect_to locker_path, notice: "Updated!"
		end
	end

	def destroy
		@ballot.destroy
		redirect_to locker_path, notice: "Your Ballot has been cancelled"
	end

	private 
	def ballot_params
		params.require(:locker_ballot).permit(:location, :locker_round_id)
	end

	def set_ballot
		@ballot = LockerBallot.find(params[:id])
	end
end
