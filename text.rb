require_relative 'near_earth_objects'
require_relative 'table_stats'
require 'date'

module Text
  include TableStats

  def launch_sequence
    welcome
  end

  def welcome
    puts "________________________________________________________________________________________________________________________________"
    puts "Welcome to NEO. Here you will find information about how many meteors, asteroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
    puts "Please enter a date in the following format YYYY-MM-DD."
    print ">>"
    @date ||= gets.chomp
    results
  end

  def formatted_date
    DateTime.parse(@date).strftime("%A %b %d, %Y")
  end

  def results
    puts "______________________________________________________________________________"
    puts "On #{formatted_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
    puts "The largest of these was #{largest_asteroid_diameter} ft. in diameter."
    puts "\nHere is a list of objects with details:"
    puts ""
    # puts divider
    puts header
    create_rows(find_neos_by_date(@date)[:asteroid_list], column_data)
    # puts divider
  end
end
