class MyMailer < ActionMailer::Base
  default from: "admin@bitqualize.com"

	def activation_email(p_userid)
		@user = User.where(:id=>p_userid).first
		return if @user.nil?
		@url = "http://localhost:3000/welcome/activate?token=#{@user.activation_token}"
		mail(to: @user.email, subject: 'Welcome to Bitqualize')
	end

end
