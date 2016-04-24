# Re-opening string class to implement new methods
class String

	# define class method for returning the color array
	def self.colors
		color_options.keys
	end

	# define method to return the sample ouput of some color 
	def self.sample_colors	
		color_options.each { | color_name, color_code | puts "This is " + color_name.to_s.send(color_name) }
	end

	# creating instance methods with class_eval
	def self.create_colors
		color_options.each do | color_name, color_code |
			new_method = %Q{
				def #{color_name}
					"\e[#{color_code}m" + self + "\e[0m"
				end
				}
			class_eval(new_method)
			end
	end

private
	# define the available colors and their respective color codes in a hash
	def self.color_options
		{
			:red => 31,
			:green => 32,
			:yellow => 33,
			:blue => 34,
			:pink => 35,
			:light_blue => 94,
			:white => 97,
			:light_gray => 37,
			:black => 30
		}

	end

end

# Calling the class method to create the instance methods, but it does not seem to be a good way
String.create_colors