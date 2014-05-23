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

	context 'takes user input and reacts when' do

		def foo
			'This will be overridden'
		end

		it 'proof that stub! works' do
			allow(self).to receive(:foo).and_return('something else')
		end

		it '1 to take inputs and shovel them into students' do


			allow(@dir).to receive(:prompt_name).and_return('Nic')
			allow(@dir).to receive(:prompt_cohort).and_return('may')
			allow(@dir).to receive(:prompt_year).and_return(2014)

			allow(@reader).to receive(:call).and_return('1')
			@dir.interact_with_menu()

			expect(@dir.students).to eq [{name:'Nic',cohort:'may',year:2014}]
			
			
		end 



		it '2 to list inputed students' do
			
			@dir.import({name:'Nic',cohort:'may',year:2014})

			allow(@reader).to receive(:call).and_return('2')
			allow(@writer).to receive(:call).and_return("Nic from may cohort in 2014")

			expect(@dir.interact_with_menu()).to eq "Nic from may cohort in 2014"
		end


		it '3 to save inputed students to file' do
			
			@dir.import({name:'Nic',cohort:'may',year:2014})
			allow(@reader).to receive(:call).and_return('3')
			expect(@dir.interact_with_menu()).to eq [{name:'Nic',cohort:'may',year:2014}]
		end

		it '4 to list students from a file' do
			
			students = @dir.import({name:'Nic',cohort:'may',year:2014})
			@dir.save_students_to('students.csv',@dir.students)
			allow(@reader).to receive(:call).and_return('4')
			@dir.interact_with_menu()
			expect(@dir.students.include?(students.first)).to be_true
		end

		it '5 to delete a student' do
			@dir.import({name:'Nic',cohort:'may',year:2014})


			allow(@dir).to receive(:prompt_name).and_return('Nic')
		
			allow(@reader).to receive(:call).and_return('5')
			@dir.interact_with_menu()

			expect(@dir.students).to eq []
		end


		it '6 to edit a student' do
			@dir.import({name: 'Sue', cohort: 'june', year: 2014})

			allow(@reader).to receive(:call)
				.and_return('Sue')
				.and_return('cohort')
				.and_return('may')

			@dir.change('Sue', 'cohort', 'may')
			expect(@dir.students.first).to eq({name: 'Sue', cohort: 'may', year: 2014})
		end


		it '9 to exit' do
			allow(@reader).to receive(:call).and_return('9')
			expect{@dir.interact_with_menu()}.to raise_error SystemExit
		end
		
	end

end