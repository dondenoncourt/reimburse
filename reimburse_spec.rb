require 'date'
require_relative 'reimburse'

describe Itinerary do
  let(:low) { City.new('Richmond', 'LOW') }
  let(:high) { City.new('New York', 'HIGH') }

  let(:project1_set1) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,3)) }
  let(:project1_set2) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
  let(:project2_set2) { Project.new('Project 2', high, Date.new(2015,9,2), Date.new(2015,9,6)) }
  let(:project3_set2) { Project.new('Project 3', low, Date.new(2015,9,6), Date.new(2015,9,8)) }
  let(:project1_set3) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,3)) }
  let(:project2_set3) { Project.new('Project 2', high, Date.new(2015,9,5), Date.new(2015,9,7)) }
  let(:project3_set3) { Project.new('Project 3', high, Date.new(2015,9,8), Date.new(2015,9,8)) }
  let(:project1_set4) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
  let(:project2_set4) { Project.new('Project 2', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
  let(:project3_set4) { Project.new('Project 3', high, Date.new(2015,9,2), Date.new(2015,9,2)) }
  let(:project4_set4) { Project.new('Project 4', high, Date.new(2015,9,2), Date.new(2015,9,3)) }

  describe Itinerary do
    it 'builds an iterary for Set 4' do
      itinerary = Itinerary.new([project1_set4, project2_set4, project3_set4, project4_set4])
      expect(itinerary.projects.count).to eq 4
    end

    it 'builds an empty iterary' do
      itinerary = Itinerary.new()
      expect(itinerary.projects.count).to eq 0
    end
  end

  describe Project do
    let(:city) { City.new('New York', 'HIGH') }
    let(:project) { Project.new('one', city, Date.today-30, Date.today+30) }

    it 'start_date is accessible' do
      expect(project.start_date).to eq Date.today-30
    end

    it 'end_date is accessible' do
      expect(project.end_date).to eq Date.today+30
    end

    it 'has a project name of one' do
      expect(project.name).to eq 'one'
    end

    it 'has a City' do
      expect(project.city_name).to eq 'New York'
    end

    context 'Sets' do
      context 'Set 1' do
        it 'builds one project' do
          expect(project1_set1.to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15'
        end
      end

      context 'Set 2' do
        it 'builds three projects' do
          projects = [project1_set2, project2_set2, project3_set2]
          expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15'
          expect(projects[1].to_s).to eq 'Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15'
          expect(projects[2].to_s).to eq 'Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15'
        end
      end

      context 'Set 3' do
        it 'builds three projects' do
          projects = [project1_set3, project2_set3, project3_set3]
          expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15'
          expect(projects[1].to_s).to eq 'Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15'
          expect(projects[2].to_s).to eq 'Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15'
        end
      end

      context 'Set 4' do
        it 'builds four projects' do
          projects = [project1_set4, project2_set4, project3_set4, project4_set4]
          expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15'
          expect(projects[1].to_s).to eq 'Project 2: Low Cost City Start Date: 9/1/15 End Date: 9/1/15'
          expect(projects[2].to_s).to eq 'Project 3: High Cost City Start Date: 9/2/15 End Date: 9/2/15'
          expect(projects[3].to_s).to eq 'Project 4: High Cost City Start Date: 9/2/15 End Date: 9/3/15'
        end
      end
    end
  end

  describe City do
    it 'fails when cost is not LOW or HIGH' do
      expect { City.new('Richmond', 'medium') }.to raise_error(ArgumentError, "Cost must be 'LOW' or 'HIGH'")
    end

    it 'creates a high cost city' do
      expect(City.new('New York', 'HIGH').cost).to eq 'HIGH'
    end
  end
end

# add a readme
# add reimbursement rules
# do RuboCop fixes
