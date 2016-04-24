require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require 'colorizr'

#After your tests pass, uncomment this code below
#=========================================================
# # Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!
#
# # Create two new tribes with names
# Create the header for the game
puts "=============Survivor Game ============="
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@coyopa.print_members
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))
@hunapu.print_members
#
# # Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================

#This is where you will write your code for the three phases
# Phase one is to eliminate 8 contestants randomly from both tribes
def phase_one
	voted_out_array = Array.new
	8.times do
	voted_out = @borneo.immunity_challenge.tribal_council(no_immune: nil) # Returns the voted out member
	voted_out_array << voted_out 
	end
	puts "Eliminated Members after 8 rounds from both tribes:"
	voted_out_array.each {|loser| print "#{loser} ".red}
	voted_out_array.length 
end

# Phase two is to return the number of eliminated contestants 
def phase_two
	voted_out_array = Array.new
	@borneo.reset_tribe(@merge_tribe) # recreate a new game with the new tribe
	3.times do
	winner = @borneo.individual_immunity_challenge # pick the winner
	voted_out = @merge_tribe.tribal_council(immune: winner) # returns the voted out member
	voted_out_array << voted_out
	end
	puts "\n\nEliminated Members after 3 individual rounds:"
	voted_out_array.each {|loser| print "#{loser} ".red}
	voted_out_array.length
end

# Phase 3 is to return the number of eliminated contestants which is the jury as well
def phase_three
	@borneo.reset_tribe(@merge_tribe) # recreate a new game with the new tribe
	7.times do
	winner = @borneo.individual_immunity_challenge # pick the winner
	voted_jury = @merge_tribe.tribal_council(immune: winner) # returns loser as jury
	@jury.add_member(voted_jury)
	end
	@jury.members.length
end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
puts "\n\nPhase 1\n===========\n" # Phase 1 header
phase_one #8 eliminations

puts "\n\nPhase 2\n===========\n" # Phase 2 header
print "New Merged Tribe for remaining 12 members"
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
@merge_tribe.print_members
phase_two #3 more eliminations

puts "\n\nPhase 3\n===========\n" # Phase 3 header
@jury = Jury.new
puts "Final members left for last round of #{@borneo.tribes.first.name.blue} tribe"
@merge_tribe.print_members
phase_three #7 elminiations become jury members
puts "\n\nEliminated members after 7 challenges assigned to Jury:"
@jury.print_members	
finalists = @merge_tribe.members #set finalists
puts "\n\nFinalists:"
finalists.each {|each_finalist| print "#{each_finalist} ".yellow}

puts"\n\nFinal Tribal Council\n======================"
puts"Jury casting their votes 1 by 1:"
vote_results = @jury.cast_votes(finalists) #Jury members report votes
puts"\nResults of Votes:"
@jury.report_votes(vote_results) #Jury announces their votes
puts"\nWinner Announcement:"
@jury.announce_winner(vote_results) #Jury announces final winner
