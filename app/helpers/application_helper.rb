module ApplicationHelper

	def has_error(p_field,p_errors)
		return "has-error" unless p_errors[p_field] == []
		return ""
	end

	def has_error_text(p_field,p_errors)
		return p_errors[p_field][0]
		
	end

end
