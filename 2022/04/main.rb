# In how many assignment pairs does one range fully contain the other?


class CampCleanup
  attr_accessor :input, :intersecting_pairs

  def initialize
    @input = IO.readlines('input.txt', chomp: true)
    @intersecting_pairs = 0
  end

  def pairs
    @pairs ||= @input.map do |line, idx|
      pair = ranges_to_lists(line)
      pair_intersection?(pair)
    end

    puts self.intersecting_pairs
  end

  def ranges_to_lists(ranges)
    ranges.split(',').map do |range|
      first, last = range.split('-')
      (first..last).to_a
    end
  end

  def pair_intersection?(pair)
    if (pair.first - pair.last).empty? || (pair.last - pair.first).empty?
      self.intersecting_pairs += 1
      true
    else
      false
    end
  end
end

cc = CampCleanup.new

cc.pairs
