# Fetches bounding boxes for cities listed in a text file (see cities.txt) and writes them to
# city_bounding_boxes.csv

require 'httparty'
require 'byebug'
require "awesome_print"
require 'csv'


cities = File.readlines('cities.txt')
# cities = CSV.read('japan_cities.csv', headers: true)
# cities = cities.filter{|x| x[0].to_i > 75_000 }.map{|x| x[1] + ", Japan" }

cities_and_boxes = {}
failed = []

CSV.open('city_bounding_boxes.csv', 'w') do |csv|


cities.each_with_index do |city, index|
  sanitized_city = city.gsub(/\t/, ", ").strip
  url = "https://nominatim.openstreetmap.org/search?format=json&q=#{CGI.escape(sanitized_city)}"

  puts "#{index} \ #{cities.size} : #{sanitized_city} -- #{url}"

  response = HTTParty.get(url, format: :json)

  place_results =  response.filter {|x| x['class'] == "place" || ( x['class'] == "boundary" &&  x["type"] == "administrative") }
  relation_results = place_results.filter {|x| x['osm_type'] == "relation"}
  node_results = place_results.filter {|x| x['osm_type'] == "node"}

  only_node_or_relation_results = response.filter {|x| ["relation", "node"].include? x['osm_type'] }
  administrative_results = only_node_or_relation_results.filter {|x|  x['class'] == "boundary" &&  x["type"] == "administrative" }
  place_results = only_node_or_relation_results.filter {|x| x['class'] == "place" }

  if administrative_results.any?
    best_result = administrative_results.first
  elsif place_results.any?
    best_result = place_results.first
  else
    best_result = nil
  end

  if best_result
    cities_and_boxes[sanitized_city] = best_result['boundingbox']
    ap best_result
    row = [sanitized_city, best_result['osm_type'],best_result['class'], best_result['boundingbox'][0], best_result['boundingbox'][1], best_result['boundingbox'][2], best_result['boundingbox'][3]]
    ap row
    csv << row
  else
    failed << sanitized_city
    puts "skipping. No match"
  end
end
end