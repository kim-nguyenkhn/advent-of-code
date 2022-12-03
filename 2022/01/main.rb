# Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
# Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?

counting_calories = 0
elves = []

IO.readlines('input.txt').each_with_index do |line, idx|

  if line.strip.empty?
    elves.push counting_calories
    counting_calories = 0
  else
    counting_calories += line.to_i
  end

end

puts elves.sort
puts elves.sort.last(3).sum