die = 1..6
minSpace = 2
maxSpace = 12
# spaces = minSpace..maxSpace
# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

results = {}

# Todo: make this a function?
# Pick spaces
(minSpace..maxSpace).each do |space1|
  ((space1 + 1)..maxSpace).each do |space2|
    ((space2 + 1)..maxSpace).each do |space3|
      spaceKey = "#{space1}:#{space2}:#{space3}"
      results[spaceKey] = 0

      # Roll dice
      die.each do |die1|
        die.each do |die2|
          die.each do |die3|
            die.each do |die4|
              spaces = [space1, space2, space3]
              dice = [die1, die2, die3, die4]
              
              # Calculate combinations
              combinations = []

              dice.each_with_index do |dieA, dieAIndex|
                dice.slice((dieAIndex + 1)..-1).each do |dieB|
                  combinations.push(dieA + dieB)
                end
              end

              combinations.uniq!

              # Check if combinations found a match.
              match = false

              spaces.each do |space|
                match = true if combinations.include?(space)
              end

              # Record results
              results[spaceKey] += 1 if match
            end
          end
        end
      end
    end
  end
end

puts results.sort_by { |spaceKey, successCount| -successCount }
