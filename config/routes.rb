Bitqualize::Application.routes.draw do

	get 'welcome/login'
	get 'welcome/signup'
	get 'welcome/trace'
	get 'welcome/forgot'
	get 'welcome/resend'
	get 'welcome/change_password'
	get 'welcome/logout'
	get 'welcome/activate'
	
	post 'welcome/forgot_send'
	post 'welcome/create_user'
	post 'welcome/change_password'
	post 'welcome/login'
	post 'welcome/resend'
	
  get "welcome/index"
	root 'welcome#index'
	
end
