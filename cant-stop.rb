# Calculate the odds of scoring (not losing progress) with various combinations of target spaces in Can't Stop.

# The general rules of Can't Stop are that you want to repeatidly roll the same group of 3 numbers so that you fill a track. You roll 4 dice and score two numbers which are combinations from the rolled dice. You can use each rolled dice once. If you cannot match your selected numbers at all, you lose progress.

# Example: 1,2,3,4 dice rolled, score possibilities [[3,7],[4,6],[5,5]]. If you were shooting for any of 3, 4, 5, 6, or 7, you could keep going. Otherwise you lose progress.

dieFaces = 1..6
boardSpaces = 2..12
numberSpacesToSelect = 3
numberDiceToRoll = 4
numberDiceToCombine = 2

# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

results = {}

boardSpaces.to_a.combination(numberSpacesToSelect) do |selectedSpaces|
  resultKey = selectedSpaces.join(',')

  results[resultKey] = 0

  dieFaces.to_a.repeated_permutation(numberDiceToRoll) do |rolledDice| 
    # Calculate combinations
    combinations = []

    rolledDice.combination(numberDiceToCombine) do |diceToCombine|
      combinations.push(diceToCombine.sum)
    end

    combinations.uniq!

    # Check if combinations found a match.
    match = false

    selectedSpaces.each do |selectedSpace|
      match = true if combinations.include?(selectedSpace)
    end

    # Record results
    results[resultKey] += 1 if match
  end
end

# Print results
dieCombinations = dieFaces.to_a.length**numberDiceToRoll

puts "Total possible combinations for dice: #{dieCombinations}"
puts "Target values: Success chance (Success combinations)"

(results.sort_by { |resultKey, successCount| -successCount }).each do |result|
  successChance = '%.2f' % ((result[1].to_f / dieCombinations) * 100)
  puts "#{result[0]}: #{successChance}% (#{result[1]})"
end
