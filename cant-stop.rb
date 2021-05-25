# Calculate the odds of scoring (not losing progress) with various combinations of target spaces in Can't Stop.

# The general rules of Can't Stop are that you want to repeatidly roll the same group of 3 numbers so that you fill a track. You roll 4 dice and score two numbers which are combinations from the rolled dice. You can use each rolled dice once. If you cannot match your selected numbers at all, you lose progress.

# Example: 1,2,3,4 dice rolled, score possibilities [[3,7],[4,6],[5,5]]. If you were shooting for any of 3, 4, 5, 6, or 7, you could keep going. Otherwise you lose progress.

die_faces = (1..6).to_a
board_spaces = (2..12).to_a
number_spaces_to_select = 3
number_dice_to_roll = 4
number_dice_to_combine = 2

# The combinations are less than 1 million 6^4 * 12c3, so let's just find exact values rather than simulate.

# Key is selected spaces like "1,2,3", value is number of rolls that are successful rolls.
successful_rolls_for_selected_spaces = {}

board_spaces.combination(number_spaces_to_select) do |selected_spaces|
  selected_spaces_key = selected_spaces.join(',')

  successful_rolls_for_selected_spaces[selected_spaces_key] = 0

  die_faces.repeated_permutation(number_dice_to_roll) do |rolled_dice| 
    rolled_spaces = rolled_dice.combination(number_dice_to_combine).to_a.map do |dice_to_combine|
      dice_to_combine.sum
    end

    rolled_spaces.uniq!

    successful_rolls_for_selected_spaces[selected_spaces_key] += 1 if (selected_spaces & rolled_spaces).any?
  end
end

# Print results
total_possible_rolls = die_faces.length**number_dice_to_roll

puts "Total possible dice rolls: #{total_possible_rolls}"
puts "Target values: Success chance (Success rolls)"

# Sorted hashes become arrays.
sorted_successful_rolls_for_selected_spaces = successful_rolls_for_selected_spaces.sort_by do |selected_spaces_key, successful_rolls|
  -successful_rolls
end

sorted_successful_rolls_for_selected_spaces.each do |(selected_spaces_key, successful_rolls)|
  success_chance = '%.2f' % ((successful_rolls.to_f / total_possible_rolls) * 100)
  puts "#{selected_spaces_key}: #{success_chance}% (#{successful_rolls})"
end
