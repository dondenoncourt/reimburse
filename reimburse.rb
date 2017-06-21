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

class Project
  attr_reader :name, :start_date, :end_date

  def initialize(name, start_date, end_date)
    @name = name
    @start_date = start_date
    @end_date = end_date
  end
end


require 'date'

describe Project do
  let(:project) { Project.new('one', Date.today-30, Date.today+30) }

  it 'start_date is accessible' do
    expect(project.start_date).to eq Date.today-30
  end

  it 'end_date is accessible' do
    expect(project.end_date).to eq Date.today+30
  end

  it 'name is "one"' do
    expect(project.name).to eq 'one'
  end
end


