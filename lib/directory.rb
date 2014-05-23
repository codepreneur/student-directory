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



end