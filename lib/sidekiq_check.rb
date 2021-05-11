module SidekiqCheck
	def initSidekiq
		begin
			ps = Sidekiq::ProcessSet.new
			if ps.size<=0
				commandFired = PidSidekiq.where("status=? and commandAt>=?", "processing", Time.current-3.minutes).first
				if !commandFired				
					# p "Sidekiq not running nor any command fired from last 3 mins"
					cmd = "bundle exec sidekiq &"
					PidSidekiq.create(status: "processing", commandAt: Time.current)
					system(cmd)
				end
			else
				PidSidekiq.destroy_all
			end
		rescue Exception => e
			p "XXXXX Exception #{e}"
		end
	end
end

# rails g model PidSidekiq status commandAt:datetime