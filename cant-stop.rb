die = 1..6
spaces = 2..12
numberSpacesToSelect = 3
numberDiceToRoll = 4
numberDiceToCombine = 2

# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

results = {}

spaces.to_a.combination(numberSpacesToSelect).to_a.each do |selectedSpaces|
  spaceKey = selectedSpaces.join(',')

  results[spaceKey] = 0

  die.to_a.repeated_permutation(numberDiceToRoll).to_a.each do |dice| 
    # Calculate combinations
    combinations = []

    dice.combination(numberDiceToCombine).to_a.each do |combinedDice|
      combinations.push(combinedDice.sum)
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

dieCombinations = die.to_a.length**numberDiceToRoll

puts "Total possible combinations for dice: #{dieCombinations}"
puts "Target value: Success chance (Success combinations)"

(results.sort_by { |spaceKey, successCount| -successCount }).each do |result|
  successChance = '%.2f' % ((result[1].to_f / dieCombinations) * 100)
  puts "#{result[0]}: #{successChance}% (#{result[1]})"
end
