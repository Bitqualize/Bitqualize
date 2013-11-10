class User < ActiveRecord::Base

	has_secure_password

	validates :email, presence: true, uniqueness: true

	before_create do
		self.activation_token = Digest::SHA2.hexdigest("#{Time.now.to_i}-#{self.email}-#{rand}")
	end

	def self.activate(p_token)
		u = User.where(:activation_token => p_token).lock(true).first
		return 1002 if u.nil?
		u.activation_token = ""
		u.active_since = Time.now()
		u.save!
		return 0
	end

	def self.login(p_email,p_password,p_ip)
		u = User.where(:email=>p_email).first
		return 1001,nil if u.nil?
		u = u.authenticate(p_password)

		return 1001,nil if u.class != User
		return 0,u
	end

	def self.change_password(p_uid,p_password,p_password_confirmation,p_reset_token)
	end

	def self.reset_password(p_email)
		n_tries = 0
		ret = 9999
		begin
			u = User.where(:email=>p_email).lock(true).first
			return 1000 if u.nil?
			u.reset_token = User.hash_the_password(rand.to_s,u.salt,u.id,u.strength)

			#TODO: Send email with the token

			u.save!
			ret = 0
		rescue => e
			n_tries += 1
			sleep 0.05
			retry unless n_tries > 3
		end
		return ret
	end

end
