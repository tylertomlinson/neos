require_relative 'near_earth_objects'
require_relative 'text'

module TableStats
  include NearEarthObjects

  def asteroid_details
    find_neos_by_date(@date)
  end

  def column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def column_data
    column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [asteroid_details[:asteroid_list].map { |asteroid| asteroid[col].size }.max, label.size].max}
      end
  end

  def header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def create_rows(asteroid_data, column_info)
    asteroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
  end
end
