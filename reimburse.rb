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

class Itinerary
  attr_accessor :projects

  def initialize(projects = [])
    @projects  = projects
  end
end
