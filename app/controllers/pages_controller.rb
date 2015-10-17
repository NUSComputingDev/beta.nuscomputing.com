class PagesController < ApplicationController
	def contact
		@feedback = Feedback.new
	end

	def alumni
	end

	def about
	end

	def election
	end

	def mc17
	end

    def mc18
        @winginfos = Winginfo.all
        @memberinfos = Memberinfo.all
    end
	
	def recruitment
	end
end
