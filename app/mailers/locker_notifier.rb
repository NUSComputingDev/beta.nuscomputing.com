class LockerNotifier < ApplicationMailer
	def test_email(user)
		@user = user
		mail to: user.email if user.email
	end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.locker_notifier.successful_ballot.subject
  #
  def successful_ballot(user, round, allocation)
    @round = round
    @locker = allocation.locker
    @greeting = "Hi #{user.uid}"
    mail to: user.email if user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.locker_notifier.unsuccessful_ballot.subject
  #
  def unsuccessful_ballot(user, round)
    @greeting = "Hi #{user.uid}"
    @round = round

    mail to: user.email if user.email
  end
end
