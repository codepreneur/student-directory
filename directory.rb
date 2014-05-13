@students = []



def print_header
	puts "The students of my cohort at Makers Academy"
	puts "--------------"
end	 


# first we print the list of students
def print_students_list
	@students.each do |student|
		puts "#{student[:name]} (#{student[:cohort]} cohort)"
	end
end

def print_footer(names)
	puts "Overall, we have #{names.length} great students"
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	#create an empty array
	# students = []

	name = gets.chomp
	while !name.empty? do
		@students << {:name => name, :cohort => :november}
		puts "Now we have #{@students.length} students"

		name = gets.chomp

	end

	# students
end


def show_students
	print_header
	print_students_list
	print_footer(@students)
end

def process(selection)
	case selection
	when "1"
		input_students
	when "2"
		show_students
	when "3"
		save_students
	when "9"
		exit
	else
		puts "I dont know what you mean, try again"
	end
end

def print_menu
	puts "1. for adding"
	puts "2. for listing what you added"
	puts "3. for saving to a csv"
	puts "9. for bye bye"
end

def interactive_menu
	loop do
		print_menu
		process(gets.chomp)
	end
end


def save_students
	file = File.open("students.csv", "w")
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(",")
		file.puts csv_line
	end
	file.close
end




interactive_menu
save_students
