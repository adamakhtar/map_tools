require 'csv'
require 'benchmark'

cities = CSV.read("#{ENV['BOUNDING_BOX_CSV_PATH']}")

def generate_cache(bounds)
  command = <<~CMD
    SSL_CERT_PATH="#{ENV['SSL_CERT_PATH']} \
    SSL_KEY_PATH="#{ENV['SSL_KEY_PATH']} \
    NE_DB_USER="#{ENV['NE_DB_USER']}" \
    NE_DB_PASS="#{ENV['NE_DB_PASS']}" \
    OSM_DB_USER="#{ENV['OSM_DB_USER']}" \
    OSM_DB_PASS="#{ENV['OSM_DB_PASS']}" \
    FILECACHE_BASEPATH="#{ENV['FILECACHE_BASEPATH']}" \
    #{ENV['EXE_PATH']} cache seed \
    --bounds "#{bounds}" \
    --max-zoom #{ENV['MAX_ZOOM']} \
    --min-zoom #{ENV['MIN_ZOOM']} \
    --config "#{ENV['CONFIG']}" \
    --concurrency #{ENV['CONCURRENCY']}
  CMD

  result = system(command)
end

def calculate_bounds(city)
  lat_a, lat_b, lng_a, lng_b = city[3..6]
  # bbox = left,bottom,right,top
  # bbox = min Longitude , min Latitude , max Longitude , max Latitude
  # (default "-180,-85.0511,180,85.0511")
  lat_top, lat_bottom = lat_a > lat_b ? [lat_a, lat_b] : [lat_b, lat_a]
  lng_left, lng_right = lng_a > lng_b ? [lng_b, lng_a] : [lng_a,  lng_b]
  bounds = "#{lng_left}, #{lat_top}, #{lng_right}, #{lat_bottom}"
end

Benchmark.bm do |x|
  cities.each_with_index do |city, index|
    bounds = calculate_bounds(city)
    x.report("BENCHMARK : #{city[0]} #{bounds}") do
      result = generate_cache(bounds)
      unless result
        failed << city
        puts "Failed"
      else
        #puts "Success"
      end
    end
  end
end