class WelcomeController < ApplicationController
  def index
  end
	
	def login
		if request.post?
			en,u = User.login(params[:user][:email],params[:user][:password],request.remote_ip)
			if en == 0
				session[:user_id] = u.id
				redirect_to :root, :notice => "You are logged in"
			else
				@user = User.new
				@user.email = params[:user][:email]
				@user.errors[:email] = error_to_text(en)
				@user.errors[:password] = error_to_text(en)
				render :login
			end
		else
			@user = User.new
		end
	end

	def activate
		en = User.activate(params[:token])
		if en == 0
			redirect_to :welcome_login, :notice => "Your account has been activated"
		else
			redirect_to :root, :alert => "Unknown activation code"
		end
		
	end

	def logout
		reset_session
		@current_user = nil
		redirect_to :root, :notice => "You are logged out"
	end

	def signup
		@user = User.new
	end

	def trace
	end

	def forgot
		@user=User.new
	end

	def forgot_send
		en = User.reset_password(params[:user][:email])
		if en == 0
			redirect_to :root, :notice => "eMail send with reset instructions."
		else
			@user=User.new
			render :forgot
		end
	end

	def resend
		if request.post?
			lock_if_brute_force_attack('RESEND',request.remote_ip)
			redirect_to :root, :alert => error_to_text(1006) and return if ip_is_locked(request.remote_ip)
			
			u = User.where(:email=>params[:user][:email]).first
			if u
				logger.debug u.to_json
				if u.activation_token != "" && !u.activation_token.nil?
					MyMailer.activation_email(u.id).deliver
					redirect_to :root, :notice => error_to_text(1003)
				else
					redirect_to :root, :alert => error_to_text(1004)
				end
			else
				redirect_to :root, :alert => error_to_text(1005)
			end
		else
			@user = User.new
		end
	end

	def change_password
		if request.post?
			if @current_user
				@user = User.where(:id=>@current_user.id).first
			else
				@user = User.where(:reset_token=>params[:user][:reset_token]).first
			end

			@user.update_attributes(params.require(:user).permit(:password,:password_confirmation))
			#en = User.change_password(uid,params[:user][:password],params[:user][:password_confirmation],params[:user][:reset_token])
			redirect_to :root, :notice => "Password changed"
		else
			@user = User.new
			@user.reset_token = params[:reset_token]
		end
	end

	def create_user

		@user = User.new(params.require(:user).permit(:email,:password,:password_confirmation))
		if @user.save
			MyMailer.activation_email(@user.id).deliver
			redirect_to :root, :notice => "We have emailed you the account activation instructions."
		else
			render :signup
		end
	end
end
