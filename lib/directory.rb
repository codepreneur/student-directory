class StudentDirectory

	require 'csv'

	def initialize(writer, reader)
		@writer = writer
		@reader = reader
		@exit = false
	end

	def students
		@students ||= []
	end

	def load_students_from(file)
		CSV.foreach(file) do |row|
			import import_from(row)
		end
	end


	def import(student)
		students << student unless students.include? student
	end


	def import_from(row)
		{
			name: row[0],
			cohort: row[1],
			year: row[2]
		}
	end

	def save_students_to(file, students)
		CSV.open(file,'wb') do |csv|
			students.each{|student| save_to_row(csv,student)}
		end
	end

	def save_to_row(row,student)
		row << student.values
	end

	def list_students(students)
		@writer.call students.map{|student| "#{student[:name]} from #{student[:cohort]} cohort in #{student[:year]}" }.join("\n")
	end


	def interact_with_menu
		option = @reader.call.chomp
		case option
		when "1" then gather_students
		when "2" then list_students(students)
		when "3" then save_students_to('students.csv',students)
		when "4" then load_students_from('students.csv')
		when "5" then delete
		when "6" then edit	
		when "9" then exit
		# when "9" then @exit = true
		else print_menu
		end

	end


	def print_menu
		menu  = "1. Input students\n"
		menu += "2. List/display students\n"
		menu += "3. Save changes to file\n"
		menu += "4. Load from file to array\n"
		menu += "5. Delete a student\n"
		menu += "6. Edit a student\n"
		menu += "9. Exit\n"
	end


	def control_flow
		load_students_from('students.csv')
		@writer.call "Welcome to student directory!"
		
		while not @exit == true
			@writer.call print_menu
			interact_with_menu
		end
	end

	def delete
		_name = prompt_name
		students.delete_if{|student| student[:name] == _name}
	end


	def edit
		student_to_edit  = prompt_name
		detail_to_change = change_what?
		detail_changed   = to_what?
		change(student_to_edit, detail_to_change, detail_changed)
	end


	def gather_students
  	_name = prompt_name
		_cohort = prompt_cohort
		_year = prompt_year
		student = {name: _name, cohort: _cohort, year: _year}
		import(student)
	end


	def prompt_name
		@writer.call "Name?"
		@reader.call.chomp
	end


	def prompt_cohort
		@writer.call "Cohort?"
		@reader.call.chomp
	end


	def prompt_year
		@writer.call "Year?"
		@reader.call.chomp
	end



	def change_what?
		@writer.call "Enter name to change name, cohort to change cohort or year to change year."
		key = @reader.call.chomp.to_sym
		raise 'Not a chance' unless [:name, :cohort, :year].include? key
		key
	end

	def to_what?
		@writer.call "to what?"
		@reader.call.chomp
	end

	def change(student_details, detail_to_change, detail_changed)
		students.each do |student|
			student[detail_to_change.to_sym] = detail_changed if student[:name] == student_details
		end
	end


	end

	if __FILE__ == $0
		StudentDirectory.new(method(:puts), method(:gets)).control_flow
	end


