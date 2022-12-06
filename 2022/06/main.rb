# How many characters need to be processed before the first start-of-packet marker is detected?

class TuningTrouble
  attr_accessor :input

  PACKET_LENGTH = 4
  MESSAGE_LENGTH = 14

  def initialize(filepath)
    @input = IO.readlines(filepath).first
  end

  def main
    input.chars.each_with_index do |_, idx|
      next if idx < MESSAGE_LENGTH

      substr = input[idx-MESSAGE_LENGTH..idx-1]

      return idx if has_unique_characters?(substr)
    end
  end

  def has_unique_characters?(str)
    str.chars.uniq.length == str.length
  end
end

tt_test = TuningTrouble.new('test.txt')
# puts tt_test.main

tt_input = TuningTrouble.new('input.txt')
puts tt_input.main