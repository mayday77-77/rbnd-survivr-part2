require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"

#After your tests pass, uncomment this code below
#=========================================================
# # Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!
#
# # Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))
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
#puts "#{@coyopa.name} : #{@coyopa.members}" # to be removed
#puts "#{@hunapu.name} : #{@hunapu.members}" # to be removed
puts "==================== start of test" # to be removed
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members	
finalists = @merge_tribe.members #set finalists
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
