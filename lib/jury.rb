require 'bundler/setup'
require 'colorizr'
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
			puts "#{each_member}".pink + " ==> Voted X".rjust(25-each_member.name.length)
		end
		return votes
	end

	# Report the count of votes for the finalists
	def report_votes(input_votes)
		input_votes.each { |each_name,each_vote | puts "#{each_name.yellow}" + " => votes: #{each_vote}".rjust(25-each_name.length)}
	end

	def announce_winner(input_votes)
		# Check to see which member has more votes and return the one with more
		winner = input_votes.max_by {| finalist, votes | votes}[0]
		puts "Survior Game Winner is #{winner}!".yellow
		return winner
	end

	# Initialize the 2 finalists with vote counts in a hash
	def finalist_group(input_finalist_array)
		finalist_hash = Hash.new
		input_finalist_array.each {| finalist_name | finalist_hash["#{finalist_name}"] = 0 } 
		return finalist_hash
	end

	# Added to print the names of the jury to screen
	def print_members
		@members.each {|each_member| print "#{each_member} ".pink}
	end

end