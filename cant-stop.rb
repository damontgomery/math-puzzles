die = 1..6
minSpace = 2
maxSpace = 12
spaces = minSpace..maxSpace
# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

results = {}

spaces.to_a.combination(3).to_a.each do |selectedSpaces|
  spaceKey = "#{selectedSpaces[0]}:#{selectedSpaces[1]}:#{selectedSpaces[2]}"

  results[spaceKey] = 0

  die.to_a.repeated_permutation(4).to_a.each do |dice| 
    # Calculate combinations
    combinations = []

    dice.combination(2).to_a.each do |combinedDice|
      combinations.push(combinedDice[0] + combinedDice[1])
    end

    combinations.uniq!

    # Check if combinations found a match.
    match = false

    selectedSpaces.each do |space|
      match = true if combinations.include?(space)
    end

    # Record results
    results[spaceKey] += 1 if match
  end
end

puts results.sort_by { |spaceKey, successCount| -successCount }
