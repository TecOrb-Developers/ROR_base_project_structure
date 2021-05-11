class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token, :only => [:notFound]

	def notFound
		# Coming here from routes last line
		respond_to do |format|
			# format.json { render :json => {result: "Invalid URL"} }
			format.any { render :json => {result: "Invalid URL"} }        
		end  
	end
end
