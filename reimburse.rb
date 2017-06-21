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
  attr_accessor :projects, :days

  def initialize(projects = [])
    @projects = projects
    build_days
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
end
