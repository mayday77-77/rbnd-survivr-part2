class Contestant

	attr_accessor :name

	def initialize(input_name)
		@name = input_name
	end

	# For the print method when to_s is called
	def to_s
		@name
	end
end