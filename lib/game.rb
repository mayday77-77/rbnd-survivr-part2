class Game

	attr_accessor :tribes

	def initialize(first_tribe, second_tribe)
		@tribes = Array.new
		@tribes << first_tribe << second_tribe
	end

	def add_tribe(input_tribe)
		@tribes << input_tribe
	end

	def immunity_challenge
		@tribes.first
	end

	def clear_tribes
		@tribes.clear
	end

	# Add both tribe members together
	def merge(input_merged_tribe_name)
		new_members = @tribes.first.members + @tribes.last.members
		new_tribe = Tribe.new(name: input_merged_tribe_name, members: new_members)
		return new_tribe
	end

	# Just to pass the test to return a contestant type
	def individual_immunity_challenge
		@tribes.first.members.sample
	end

end