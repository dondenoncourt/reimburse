require 'date'
require_relative 'reimburse'

describe Itinerary do
  let(:low) { City.new('Richmond', 'LOW') }
  let(:high) { City.new('New York', 'HIGH') }

  let(:project1_set1) { Project.new('Project 1', low, Date.new(2015, 9, 1), Date.new(2015, 9, 3)) }

  let(:project1_set2) { Project.new('Project 1', low, Date.new(2015, 9, 1), Date.new(2015, 9, 1)) }
  let(:project2_set2) { Project.new('Project 2', high, Date.new(2015, 9, 2), Date.new(2015, 9, 6)) }
  let(:project3_set2) { Project.new('Project 3', low, Date.new(2015, 9, 6), Date.new(2015, 9, 8)) }

  let(:project1_set3) { Project.new('Project 1', low, Date.new(2015, 9, 1), Date.new(2015, 9, 3)) }
  let(:project2_set3) { Project.new('Project 2', high, Date.new(2015, 9, 5), Date.new(2015, 9, 7)) }
  let(:project3_set3) { Project.new('Project 3', high, Date.new(2015, 9, 8), Date.new(2015, 9, 8)) }

  let(:project1_set4) { Project.new('Project 1', low, Date.new(2015, 9, 1), Date.new(2015, 9, 1)) }
  let(:project2_set4) { Project.new('Project 2', low, Date.new(2015, 9, 1), Date.new(2015, 9, 1)) }
  let(:project3_set4) { Project.new('Project 3', high, Date.new(2015, 9, 2), Date.new(2015, 9, 2)) }
  let(:project4_set4) { Project.new('Project 4', high, Date.new(2015, 9, 2), Date.new(2015, 9, 3)) }

  let(:project1_set5) { Project.new('Project 1', low, Date.new(2015, 9, 1), Date.new(2015, 9, 1)) }
  let(:project2_set5) { Project.new('Project 2', high, Date.new(2015, 9, 1), Date.new(2015, 9, 1)) }
  let(:project3_set5) { Project.new('Project 3', low, Date.new(2015, 9, 3), Date.new(2015, 9, 4)) }

  describe Itinerary do
    it 'builds an iterary for Set 4' do
      itinerary = Itinerary.new([project1_set4, project2_set4, project3_set4, project4_set4])
      expect(itinerary.projects.count).to eq 4
    end

    it 'builds an empty iterary' do
      expect(Itinerary.new.projects.count).to eq 0
    end

    it 'has 3 days in set 1' do
      itinerary = Itinerary.new([project1_set1])
      expect(itinerary.days.count).to eq 3
    end

    it 'has 9 days in set 2' do
      itinerary = Itinerary.new([project1_set2, project2_set2, project3_set2])
      expect(itinerary.days.count).to eq 9
    end

    it 'has 7 days in set 3' do
      itinerary = Itinerary.new([project1_set3, project2_set3, project3_set3])
      expect(itinerary.days.count).to eq 7
    end

    context 'Set 1' do
      let(:itinerary) { Itinerary.new([project1_set1]) }

      it 'calculates the correct reimbursement' do
        expect(itinerary.reimbursement).to eq 165
      end

      it 'has 3 specific dates' do
        expect(itinerary.to_s).to eq ['2015-09-01', '2015-09-02', '2015-09-03']
      end

      it 'each unique date has a reimbursement rate' do
        reimbursement_rates = itinerary.days.map { |day| day[:project].city.cost }
        expect(reimbursement_rates).to eq %w[LOW LOW LOW]
      end

      it 'each unique date has a reimbursement rate' do
        expect(itinerary.reimbursements).to eq [45, 75, 45]
      end
    end

    context 'Set 2' do
      let(:itinerary) { Itinerary.new([project1_set2, project2_set2, project3_set2]) }

      it 'calculates the correct reimbursement' do
        expect(itinerary.reimbursement).to eq 590
      end

      it 'has 9 specific dates' do
        expect(itinerary.to_s).to eq(
          ['2015-09-01', '2015-09-02', '2015-09-03', '2015-09-04', '2015-09-05', '2015-09-06', '2015-09-06',
           '2015-09-07', '2015-09-08']
        )
      end

      it 'each unique date has a reimbursement rate' do
        reimbursement_rates = itinerary.days.map { |day| day[:project].city.cost }
        expect(reimbursement_rates).to eq %w[LOW HIGH HIGH HIGH HIGH HIGH LOW LOW LOW]
      end

      it 'each unique date has a reimbursement rate' do
        expect(itinerary.reimbursements).to eq [45, 85, 85, 85, 85, 85, 75, 45]
      end
    end

    context 'Set 3' do
      let(:itinerary) { Itinerary.new([project1_set3, project2_set3, project3_set3]) }

      it 'calculates the correct reimbursement' do
        expect(itinerary.reimbursement).to eq 445
      end

      it 'has 7 specific dates' do
        expect(itinerary.to_s).to eq(
          ['2015-09-01', '2015-09-02', '2015-09-03', '2015-09-05', '2015-09-06', '2015-09-07', '2015-09-08']
        )
      end

      it 'each unique date has a reimbursement rate' do
        reimbursement_rates = itinerary.days.map { |day| day[:project].city.cost }
        expect(reimbursement_rates).to eq %w[LOW LOW LOW HIGH HIGH HIGH HIGH]
      end

      it 'each unique date has a reimbursement rate' do
        expect(itinerary.reimbursements).to eq [45, 75, 45, 55, 85, 85, 55]
      end
    end

    context 'Set 4' do
      let(:itinerary) { Itinerary.new([project1_set4, project2_set4, project3_set4, project4_set4]) }

      it 'calculates the correct reimbursement' do
        expect(itinerary.reimbursement).to eq 185
      end

      it 'has 5 specific dates' do
        expect(itinerary.to_s).to eq ['2015-09-01', '2015-09-01', '2015-09-02', '2015-09-02', '2015-09-03']
      end

      it 'each unique date has a reimbursement rate' do
        reimbursement_rates = itinerary.days.map { |day| day[:project].city.cost }
        expect(reimbursement_rates).to eq %w[LOW LOW HIGH HIGH HIGH]
      end

      it 'each unique date has a reimbursement rate' do
        expect(itinerary.reimbursements).to eq [45, 85, 55]
      end
    end

    context 'Set 5' do
      let(:itinerary) { Itinerary.new([project1_set5, project2_set5, project3_set5]) }

      it 'calculates the correct reimbursement' do
        expect(itinerary.reimbursement).to eq 135
      end

      it 'has 5 specific dates' do
        expect(itinerary.to_s).to eq ["2015-09-01", "2015-09-01", "2015-09-03", "2015-09-04"]
      end

      it 'each unique date has a reimbursement rate' do
        reimbursement_rates = itinerary.days.map { |day| day[:project].city.cost }
        expect(reimbursement_rates).to eq %w[LOW HIGH LOW LOW]
      end

      it 'each unique date has a reimbursement rate' do
        expect(itinerary.reimbursements).to eq [45, 45, 45]
      end
    end
  end

  describe Project do
    let(:city) { City.new('New York', 'HIGH') }
    let(:project) { Project.new('one', city, Date.today - 30, Date.today + 30) }

    it 'start_date is accessible' do
      expect(project.start_date).to eq Date.today - 30
    end

    it 'end_date is accessible' do
      expect(project.end_date).to eq Date.today + 30
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

      context 'Set 5' do
        it 'builds five projects' do
          projects = [project1_set5, project2_set5, project3_set5]
          expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15'
          expect(projects[1].to_s).to eq 'Project 2: High Cost City Start Date: 9/1/15 End Date: 9/1/15'
          expect(projects[2].to_s).to eq 'Project 3: Low Cost City Start Date: 9/3/15 End Date: 9/4/15'
        end
      end
    end
  end

  describe City do
    it 'fails when cost is not LOW or HIGH' do
      expect { City.new('Richmond', 'medium') }.to(
        raise_error(ArgumentError, "Cost must be 'LOW' or 'HIGH'")
      )
    end

    it 'creates a high cost city' do
      expect(City.new('New York', 'HIGH').cost).to eq 'HIGH'
    end
  end
end
