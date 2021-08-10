# Returns the number of tiles within a given bounding box and zoom level
# taken from https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#Lon..2Flat._to_tile_numbers_3

require 'byebug'
require 'csv'


def tiles_in_bbox(lng_min:, lng_max:, lat_min:, lat_max:, zoom:)
  lng_min = lng_min.to_f
  lng_max = lng_max.to_f
  lat_min = lat_min.to_f
  lat_max = lat_max.to_f

  top_left = get_tile_number(lat_deg: lat_min, lng_deg: lng_min, zoom: zoom)
  bottom_right = get_tile_number(lat_deg: lat_max, lng_deg: lng_max, zoom: zoom)

  horizontal_tiles = generate_range(top_left[:x], bottom_right[:x])
  vertical_tiles =  generate_range(top_left[:y], bottom_right[:y])

  horizontal_tiles.product(vertical_tiles).map {|x, y| {x: x, y: y, z: zoom}}
end

def generate_range(from, to)
  if from == to
    return [from]
  else
    (from..to).to_a
  end
end

def get_tile_number(lat_deg:, lng_deg:, zoom:)
  lat_rad = lat_deg/180 * Math::PI
  n = 2.0 ** zoom
  x = ((lng_deg + 180.0) / 360.0 * n).to_i
  y = ((1.0 - Math::log(Math::tan(lat_rad) + (1 / Math::cos(lat_rad))) / Math::PI) / 2.0 * n).to_i

  {:x => x, :y =>y}
end

tile_results = {}

cities = CSV.read("../bounding_boxes/city_bounding_boxes.csv")

(3..10).to_a.each do |zoom|
  zoom_tile_results = []
  cities.each do |city|
    lat_a, lat_b, lng_a, lng_b = city[3..6]

    lat_top, lat_bottom = lat_a > lat_b ? [lat_a, lat_b] : [lat_b, lat_a]
    lng_left, lng_right = lng_a > lng_b ? [lng_b, lng_a] : [lng_a,  lng_b]


    tiles = tiles_in_bbox(lng_min: lng_left, lng_max: lng_right, lat_min: lat_top, lat_max: lat_bottom, zoom: zoom)


    zoom_tile_results += tiles
  end

  tile_results[zoom] = zoom_tile_results.uniq.size
end


tile_results.each do |zoom, tile_count|
  puts "#{zoom}: #{tile_count}\n"
end

total_tiles = tile_results.inject(0) {|memo, (zoom, tile_count)| memo += tile_count; memo; }
puts total_tiles
puts ((total_tiles * 20) / 60 / 60 / 24).to_s




########################################################
# TESTS - Uncomment to run
#-------------------------------------------------------

# Used for tests only (see end of file)
# def assert(name, actual, expected)
#   if actual != expected
#     puts "#{name}: failed. expected #{expected} but actual was #{actual}"
#   else
#     puts "#{name}: pass"
#   end
# end

# assert("tile number for top left", get_tile_number( lng_deg: -180, lat_deg: 85.0511, zoom: 2), {x: 0, y:0})
# assert("tile number for bottom left", get_tile_number( lng_deg: -180, lat_deg: -85.0511, zoom: 2), {x: 0, y: 3})
# assert("tile number for top right", get_tile_number( lng_deg: 179.99, lat_deg: 85.0511, zoom: 2), {x: 3, y: 0})
# assert("tile number for bottom right", get_tile_number( lng_deg: 179.99, lat_deg: -85.0511, zoom: 2), {x: 3, y: 3})

# result = tiles_in_bbox(lng_min: -179.99, lng_max: 179.99, lat_min: 85.0511 , lat_max: -85.0511 , zoom: 2).size
# assert("whole map", result, 16)

# result = tiles_in_bbox(lng_min: -179.99, lng_max: -0.1, lat_min: 85 , lat_max: -85 , zoom: 2).size
# assert("left half of map", result, 8)

# result = tiles_in_bbox(lng_min: 0, lng_max: 179.99, lat_min: 85 , lat_max: -85 , zoom: 2).size
# assert("right half of map", result, 8)

# result = tiles_in_bbox(lng_min: -179.99, lng_max: 179.99, lat_min: 85 , lat_max: 0.1, zoom: 2).size
# assert("top half of map", result, 8)

# result = tiles_in_bbox(lng_min: -179.99, lng_max: 179.99, lat_min: 0, lat_max: -85, zoom: 2).size
# assert("bottom half of map", result, 8)
