class Jury

	attr_accessor :members

	def initialize
		@members = Array.new
	end

	# Add jury name to the member array
	def add_member(input_jury)
		@members << input_jury
	end

	# Return a hash type for votes after member has cast them
	def cast_votes(input_finalist_array)
		votes = finalist_group(input_finalist_array)
		# Looping the member array to cast randomly their votes into the array and printing the jury to stdout
		@members.each do | each_member | 
			votes[votes.to_a.sample[0]] += 1
			puts "#{each_member}".pink + " ===> Voted XX"
		end
		return votes
	end

	def report_votes(input_votes)
		input_votes.each { |each_name,each_vote | puts "#{each_name.yellow} => #{each_vote}"}
	end

	def announce_winner(input_votes)
		# check to see if this could be refactored
		winner = input_votes.to_a.first[1] > input_votes.to_a.last[1] ? input_votes.to_a.first[0] : input_votes.to_a.last[0]
		puts "Winner is #{winner}!".yellow
		return winner
	end

	# Initialize the 2 finalists with vote counts in a hash
	def finalist_group(input_finalist_array)
		finalist_hash = Hash.new
		input_finalist_array.each {| finalist_name | finalist_hash["#{finalist_name}"] = 0 } 
		return finalist_hash
	end

	def print_members
		@members.each {|each_member| print "#{each_member} ".pink}
	end

end