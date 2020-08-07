require 'rubygems'
require 'histogram/array'

boardSizes = 10..10
sampleSize = 1000000

boardSizes.each do |maxSpaces|
  results = []

  (1..sampleSize).each do
    jumps = 0
    traveled = 0

    while traveled < maxSpaces do
      availableSpaces = (1..(maxSpaces - traveled)).to_a

      traveled += availableSpaces.sample

      jumps += 1
    end

    results.push(jumps)
  end

  puts "Histogram for #{maxSpaces}:"

  (bins, frequencies) = results.histogram(:bin_width => 1)

  bins.each_with_index do |bin, index|
    puts "#{bin}: #{(100 * (frequencies[index] / sampleSize)).to_i}"
  end

  avg = results.sum(0.0) / results.size
  puts "Average for #{maxSpaces}: #{avg}"
end
