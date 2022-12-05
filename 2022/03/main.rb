# What is the sum of the priorities of those item types?

# A = 65

LOWER_CASE_MAGIC_NUMBER = 96
UPPER_CASE_MAGIC_NUMBER = 38


class RucksackReorganizer
  attr_accessor :rucksacks, :total

  def initialize
    @rucksacks = IO.readlines('input.txt')
    @total = 0
  end

  def calculate_total_priority
    rucksack_triads = rucksacks.each_slice(3).to_a

    rucksack_triads.each_with_index do |rucksack_triad, idx|
      badge_letter = find_triad_badge(rucksack_triad)

      self.total += prioritize_item(badge_letter)

    end

    self.total
  end

  def calculate_priority_of_badge_letter(rucksack, badge_letter)
    # split each rucksack into two compartment arrays
    first_compartment = rucksack[0..rucksack.length/2 - 1]
    second_compartment = rucksack[rucksack.length/2, rucksack.length]

    intersection = first_compartment.chars & second_compartment.chars

    intersection.map(&method(:prioritize_item)).sum
  end

  # item = a-z (1-26) or A-Z (27-52)
  def prioritize_item(item)
    char_code = item.ord

    if item == item.downcase
      char_code - LOWER_CASE_MAGIC_NUMBER
      priority = char_code - LOWER_CASE_MAGIC_NUMBER
    else
      char_code - UPPER_CASE_MAGIC_NUMBER
      priority = char_code - UPPER_CASE_MAGIC_NUMBER
    end

    priority
  end

  # @param triad [String, String, String]
  def find_triad_badge(triad)
    intersection = (triad[0].chars & triad[1].chars & triad[2].chars)
    intersection.reject { |char| char == "\n" }.first
  end
end

puts RucksackReorganizer.new().calculate_total_priority