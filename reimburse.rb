# A few rules:
# First day and last day of a project, or sequence of projects, is a travel day.
# Any day in the middle of a project, or sequence of projects, is considered a full day.
# If there is a gap between projects, then the days on either side of that gap are travel days.
# If two projects push up against each other, or overlap, then those days are full days as well.
# Any given day is only ever counted once, even if two projects are on the same day.
# A travel day is reimbursed at a rate of 45 dollars per day in a low cost city.
# A travel day is reimbursed at a rate of 55 dollars per day in a high cost city.
# A full day is reimbursed at a rate of 75 dollars per day in a low cost city.
# A full day is reimbursed at a rate of 85 dollars per day in a high cost city.
#
# Given the following sets of projects, provide code which will calculate the reimbursement for each.
#
# Set 1:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
#
# Set 2:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15
#   Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15
#
#
# Set 3:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15
#   Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15
#   Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15
#
# Set 4:
#   Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 2: Low Cost City Start Date: 9/1/15 End Date: 9/1/15
#   Project 3: High Cost City Start Date: 9/2/15 End Date: 9/2/15
#   Project 4: High Cost City Start Date: 9/2/15 End Date: 9/3/15
#

require 'forwardable'

class Project
  extend Forwardable

  attr_reader :name, :start_date, :end_date, :city

  def_delegators :@city, :cost

  def initialize(name, city, start_date, end_date)
    @name = name
    @start_date = start_date
    @end_date = end_date
    @city = city
  end

  def city_name
    city.name
  end

  def to_s
    "#{name}: #{cost.capitalize} Cost City Start Date: #{start_date.strftime("%-m/%-d/%y")} End Date: #{end_date.strftime("%-m/%-d/%y")}"
  end
end

class City
  attr_reader :name, :cost

  def initialize(name, cost)
    @name = name
    raise ArgumentError.new("Cost must be 'LOW' or 'HIGH'") unless ['LOW', 'HIGH'].include?(cost)
    @cost = cost
  end
end

require 'date'

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
    let(:low) { City.new('Richmond', 'LOW') }
    let(:high) { City.new('New York', 'HIGH') }

    context 'Set 1' do
      let(:project1) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,3)) }

      it 'builds one project' do
        expect(project1.to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15'
      end
    end

    context 'Set 2' do
      let(:project1) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
      let(:project2) { Project.new('Project 2', high, Date.new(2015,9,2), Date.new(2015,9,6)) }
      let(:project3) { Project.new('Project 3', low, Date.new(2015,9,6), Date.new(2015,9,8)) }

      it 'builds three projects' do
        projects = [project1, project2, project3]
        expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/1/15'
        expect(projects[1].to_s).to eq 'Project 2: High Cost City Start Date: 9/2/15 End Date: 9/6/15'
        expect(projects[2].to_s).to eq 'Project 3: Low Cost City Start Date: 9/6/15 End Date: 9/8/15'
      end
    end

    context 'Set 3' do
      let(:project1) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,3)) }
      let(:project2) { Project.new('Project 2', high, Date.new(2015,9,5), Date.new(2015,9,7)) }
      let(:project3) { Project.new('Project 3', high, Date.new(2015,9,8), Date.new(2015,9,8)) }

      it 'builds three projects' do
        projects = [project1, project2, project3]
        expect(projects[0].to_s).to eq 'Project 1: Low Cost City Start Date: 9/1/15 End Date: 9/3/15'
        expect(projects[1].to_s).to eq 'Project 2: High Cost City Start Date: 9/5/15 End Date: 9/7/15'
        expect(projects[2].to_s).to eq 'Project 3: High Cost City Start Date: 9/8/15 End Date: 9/8/15'
      end
    end

    context 'Set 4' do
      let(:project1) { Project.new('Project 1', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
      let(:project2) { Project.new('Project 2', low, Date.new(2015,9,1), Date.new(2015,9,1)) }
      let(:project3) { Project.new('Project 3', high, Date.new(2015,9,2), Date.new(2015,9,2)) }
      let(:project4) { Project.new('Project 4', high, Date.new(2015,9,2), Date.new(2015,9,3)) }

      it 'builds four projects' do
        projects = [project1, project2, project3, project4]
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
