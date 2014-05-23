require 'directory'

describe 'student directory' do

	before(:each) do
		@writer = double('writer')
		@reader = double('reader')
    @dir = StudentDirectory.new(@writer, @reader)
  	end
 
	context 'loading data' do

		it 'there are no students' do
			expect(@dir.students).to be_empty
		end

		it 'loads from a file' do
			
			expect(CSV).to receive(:foreach).with('students.csv')
			@dir.load_students_from('students.csv')
		end

		it 'imports a student' do
			
			student = {name:'Nic',cohort:'may',year:2014}
			@dir.import(student)
			expect(@dir.students).to eq [student]
		end

		it 'creates a student' do
			
			student = {name:'Nic',cohort:'may',year:2014}
		  expect(@dir.import_from(['Nic','may',2014])).to eq student
		end

	end


	context 'saving data' do

		it 'saves a student to file' do
			
			expect(CSV).to receive(:open).with('students.csv','wb')
			@dir.save_students_to('students.csv',@dir.students)
		end

		it 'saves to row' do
			
			student = {name: "Nic", cohort: "May", year: 2014}
			expect(@dir.save_to_row([],student)).to eq [["Nic","May",2014]]
		end

	end


	context 'listing/displaying students' do

		it 'displays students' do
			
			students = [{name:'Nic',cohort:'may',year:2014},{name:'Paul',cohort:'may',year:2014}]

			expect(@writer).to receive(:call).with("Nic from may cohort in 2014\nPaul from may cohort in 2014")

			@dir.list_students(students)
		end

	end

	


end