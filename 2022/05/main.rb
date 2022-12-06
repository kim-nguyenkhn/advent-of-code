# After the rearrangement procedure completes, what crate ends up on top of each stack?

class SupplyStacks
  attr_accessor :input, :crates, :instructions

  def initialize
    @input = IO.readlines('input.txt', chomp: true)
    @crates = {}

    begin_building
  end

  def begin_building
    instructions_starting_index = build_crates
    perform_instructions(instructions_starting_index)

    puts self.crates
    puts get_top_crates_string
  end

  def build_crates
    input.each_with_index do |line, idx|
      if line.include?('1')
        puts "begin instructions at index #{idx+1}"
        self.crates = crates.sort.to_h
        return idx+1
      else
        parsed_line = line.gsub(/\s\s\s\s/, '[   ')

        crate_idx = 0
        puts parsed_line
        parsed_line.chars.each_with_index do |char|
          if char == ' ' || char == ']'
            next
          elsif char == '['
            crate_idx += 1
          else
            if crates[crate_idx].nil?
              crates[crate_idx] = []
            end

            crates[crate_idx].push(char)
          end
          # puts "char: #{char}, crate_idx: #{crate_idx}"
        end
      end
    end
  end

  def perform_instructions(starting_index)
    puts self.crates
    input.each_with_index do |line, idx|
      next if idx <= starting_index

      parsed_line = line.gsub(/\D/, ' ')
      count, from, to = parsed_line.split(' ')
      move(count.to_i, from.to_i, to.to_i)
    end
  end

  def move(count, from, to)
    # puts "move #{count} from #{from} to #{to}"

    movable_list = crates[from].shift(count)
    # puts movable_list.to_s

    movable_list.reverse.each do |crate|
      # puts crate
      crates[to].unshift crate
    end

    # puts "crates: #{crates}"
    # puts
  end

  def get_top_crates_string
    self.crates.values.map do |list|
      list.first
    end.join
  end
end

ss = SupplyStacks.new