class Tribe

	attr_accessor :name, :members

	def initialize(input_tribe_hash)
		@name = input_tribe_hash[:name]
		@members = input_tribe_hash[:members] # array of 10 contestants
		print_tribe_name
	end

	def to_s
		@name
	end

	# return a contestant
	def tribal_council(input_immune_contestant) 
		if input_immune_contestant[:immune] # if immune member is provided
			resultant_member = @members.reject {|each_member| each_member == input_immune_contestant[:immune]}.sample
			@members.delete(resultant_member)
		else # else if no immune member provided - phase 1
			resultant_member = @members.sample
			@members.delete(resultant_member)
		end
		return resultant_member
	end

	# Added to output the tribe details to screen with colorizr
	def print_tribe_name
		puts "\nParticipating Tribe: #{@name.blue}"
	end

	def print_members
		print "Members: "
		@members.each {|each_member| print "#{each_member} ".green}
	end

end

