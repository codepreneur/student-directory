students = [
	 {:name => "Roi Driscoll", :cohort => :november},
	 {:name => "James Whyte", :cohort => :november},
	 {:name => "Margherita Serino", :cohort => :november},
	 {:name => "Vaidas Mykolaitis", :cohort => :november},
	 {:name => "Johann Bornman", :cohort => :november},
	 {:name => "Kate Hamilton", :cohort => :november},
	 {:name => "James Keap", :cohort => :november},
	 {:name => "Nic Yeeles", :cohort => :november},
	 {:name => "Julie Walker", :cohort => :november},
	 {:name => "Will Allen", :cohort => :november},
	 {:name => "Julia Tan", :cohort => :november},
	 {:name => "Federico Maffei", :cohort => :november},
	 {:name => "Jamie Patel", :cohort => :november},
	 {:name => "Faezrah Rizalman", :cohort => :november},
	 {:name => "Josh Fail-Broon", :cohort => :november},
	 {:name => "Sasha Cooper", :cohort => :november},
	 {:name => "Nicolai DTH", :cohort => :november},
	 {:name => "Nadav Matalon", :cohort => :november},
	 {:name => "Fitsum Teklehaimanot", :cohort => :november}
	 ]

def print_header
	puts "The students of my cohort at Makers Academy"
	puts "--------------"
end	 


# first we print the list of students
def print(students)
	students.each do |student|
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
	students = []

	name = gets.chomp
	while !name.empty? do
		students << {:name => name, :cohort => :november}
		puts "Now we have #{students.length} students"

		name = gets.chomp

	end

	students
end



students = input_students
print_header
print(students)
print_footer(students)

