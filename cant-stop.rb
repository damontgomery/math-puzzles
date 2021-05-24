# Calculate the odds of scoring (not losing progress) with various combinations of target spaces in Can't Stop.

# The general rules of Can't Stop are that you want to repeatidly roll the same group of 3 numbers so that you fill a track. You roll 4 dice and score two numbers which are combinations from the rolled dice. You can use each rolled dice once. If you cannot match your selected numbers at all, you lose progress.

# Example: 1,2,3,4 dice rolled, score possibilities [[3,7],[4,6],[5,5]]. If you were shooting for any of 3, 4, 5, 6, or 7, you could keep going. Otherwise you lose progress.

dieFaces = (1..6).to_a
boardSpaces = (2..12).to_a
numberSpacesToSelect = 3
numberDiceToRoll = 4
numberDiceToCombine = 2

# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

# Key is selected spaces like "1,2,3", value is number of rolls that are successful rolls.
successfulRollsForSelectedSpaces = {}

boardSpaces.combination(numberSpacesToSelect) do |selectedSpaces|
  selectedSpacesKey = selectedSpaces.join(',')

  successfulRollsForSelectedSpaces[selectedSpacesKey] = 0

  dieFaces.repeated_permutation(numberDiceToRoll) do |rolledDice| 
    rolledSpaces = rolledDice.combination(numberDiceToCombine).to_a.map do |diceToCombine|
      diceToCombine.sum
    end

    rolledSpaces.uniq!

    successfulRollsForSelectedSpaces[selectedSpacesKey] += 1 if (selectedSpaces & rolledSpaces).length > 0
  end
end

# Print results
totalPossibleRolls = dieFaces.length**numberDiceToRoll

puts "Total possible dice rolls: #{totalPossibleRolls}"
puts "Target values: Success chance (Success rolls)"

# Sorted hashes become arrays.
sortedSuccessfulRollsForSelectedSpaces = successfulRollsForSelectedSpaces.sort_by do |selectedSpacesKey, successfulRolls|
  -successfulRolls
end

sortedSuccessfulRollsForSelectedSpaces.each do |(selectedSpacesKey, successfulRolls)|
  successChance = '%.2f' % ((successfulRolls.to_f / totalPossibleRolls) * 100)
  puts "#{selectedSpacesKey}: #{successChance}% (#{successfulRolls})"
end
