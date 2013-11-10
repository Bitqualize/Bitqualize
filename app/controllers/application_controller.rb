class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user

	def error_to_text(p_error_number)
		r = case p_error_number
		when 1001 then 'Wrong email or password.'
		when 1002 then 'Unkown activation code.'
		when 1003 then 'Activation email was sent again.'
		when 1004 then 'Account is already activated.'
		when 1005 then 'Email does not exist.'
		when 1006 then 'IP address is blocked for 5 Minutes due to too frequent errors'
			else "ERROR"
		end
	end

	def current_user
		@current_user ||= User.where(:id=>session[:user_id]).first if session[:user_id]
	end

	def lock_if_brute_force_attack(p_function,p_ip)
		# Count how often a function is called within a minute, lock the IP if the threshold is exceeded

		# Thresholds
		p = {}
		p["RESEND"] = {:qty=>3, :lockduration=>600}
		p["LOGIN"] = {:qty=>3, :lockduration=>600}

		p_function.upcase!

		# Increase counter
		r = CACHE.get("ADMIN-BRUTE-#{p_function}-#{p_ip}")
		r = 0 if r.nil?
		r += 1

		# Save the data
		CACHE.set("ADMIN-BRUTE-#{p_function}-#{p_ip}",r,60)
		CACHE.set("ADMIN-LOCK-IP-#{p_ip}",p[p_function][:lockduration]) if r > p[p_function][:qty]
	end

	def ip_is_locked(p_ip)
		return true if CACHE.get("ADMIN-LOCK-IP-#{p_ip}")
		return false
	end

end
