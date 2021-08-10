# Probably not of any use now. Feed this script the console output of running imposm and it will
# calculate the average time to calculate a tile at each zoom level.

# Copy and paste the imposm console output to a file named zoom_processing_time.txt.
# Edit it so it only includes output concerning time to generate a tile.
# Edit each line to follow this format:
# (6/11/22) took: 2255ms
# (7/31/49) took: 2168ms
# etc etc etc

require 'byebug'
require 'awesome_print'
processing_time = {}
File.readlines('zoom_processing_time.txt').each do |line|
  match = line.match(/\((^\d\d?).*?took: (\d*?)ms/)

  zoom = match[1]
  time = match[2].to_i

  processing_time[zoom] ||= {count: 0, total_time: 0}
  processing_time[zoom][:count] += 1
  processing_time[zoom][:total_time] += time
end

processing_time.each do |zoom, data|
  puts "#{zoom} Total titles: #{data[:count]} Avg Time: #{data[:total_time] / 1000 / data[:count]}s"
end
