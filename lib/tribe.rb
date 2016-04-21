class Tribe

	attr_accessor :name, :members

	def initialize(input_tribe_hash)
		@name = input_tribe_hash[:name]
		puts to_s
		@members = input_tribe_hash[:members] # array of 10 contestants
	end

	def to_s
		@name
	end

	# return value must not be the immune contestant
	def tribal_council(input_immune_contestant) 
		begin
			random_member = @members.sample
		end while random_member == input_immune_contestant[:immune]		
		return random_member
	end

end

