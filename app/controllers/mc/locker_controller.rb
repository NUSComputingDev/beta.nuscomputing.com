class Mc::LockerController < Mc::BaseController
  def home
  	@current_round = LockerRound.active_at(DateTime.now).first
		@last_round = LockerRound.where('end < ?', DateTime.now).order({end: :desc}).first
  end

  def allocate
		AllocateLockerJob.perform_later params[:round]
		redirect_to mc_locker_locker_rounds_path, notice: "Allocation is completed for the round."
	end

	def email
		LockerNotifier.test_email(current_user).deliver_later 
		redirect_to mc_locker_path, notice: "Email sent"
	end
end
