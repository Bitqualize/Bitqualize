class Parameter < ActiveRecord::Base

	validates :paramname, :uniqueness => true

	def self.get_parameter(p_name)
		ret = Parameter.where(:paramname=>p_name).first
		return"" if ret.nil?
		return ret.paramvalue
	end

end
