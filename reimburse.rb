require 'forwardable'
require 'byebug'

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
    "#{name}: #{cost.capitalize} Cost City Start Date: "\
    "#{start_date.strftime('%-m/%-d/%y')} End Date: #{end_date.strftime('%-m/%-d/%y')}"
  end
end

class City
  attr_reader :name, :cost

  def initialize(name, cost)
    @name = name
    raise ArgumentError, "Cost must be 'LOW' or 'HIGH'" unless %w[LOW HIGH].include?(cost)
    @cost = cost
  end
end

class Itinerary
  attr_accessor :projects
  attr_reader :days, :reimbursements

  def initialize(projects = [])
    @projects = projects
    build_days
    build_reimbursements
  end

  def to_s
    days.map { |day| day[:date].to_s }
  end

  def reimbursement
    @reimbursements.inject(0){ |sum, x| sum + x }
  end

  private

  def build_days
    @days = []
    @projects.each do |project|
      (project.start_date..project.end_date).each do |day|
        days << { date: day, project: project }
      end
    end
  end

  def build_reimbursements
    @reimbursements = []
    @days.each_with_index do |date, index|
      if first_day?(index)
        @reimbursements << travel_day_cost(date)
      elsif day_already_processed?(date, index)
        next
      elsif last_day?(index)
        @reimbursements << travel_day_cost(date)
      elsif gap?(date, index)
        @reimbursements << travel_day_cost(date)
      else
        @reimbursements << full_day_cost(date)
      end
    end
  end

  def day_already_processed?(date, index)
    date[:date] == @days[index - 1][:date]
  end

  def gap?(date, index)
    return false if first_day?(index) || last_day?(index)
    gap_before = (date[:date] - @days[index - 1][:date]).to_i > 1
    gap_after = (@days[index + 1][:date] - date[:date]).to_i > 1
    gap_before || gap_after ? true : false
  end

  def first_day?(index)
    index.zero?
  end

  def last_day?(index)
    @days.count == index + 1
  end

  def travel_day_cost(date)
    date[:project].city.cost == 'LOW' ? 45 : 55
  end

  def full_day_cost(date)
    date[:project].city.cost == 'LOW' ? 75 : 85
  end
end
