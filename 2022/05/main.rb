# After the rearrangement procedure completes, what crate ends up on top of each stack?

class SupplyStacks
  attr_accessor :input, :crates, :instructions

  def initialize
    @input = IO.readlines('test.txt', chomp: true)
    @crates = {}

    begin_building

    # TODO:
    # read the input, and create two data structures:
    # 1. initial crates hash
    # 2. instructions list

    # perform instructions from list
  end

  def begin_building
    instructions_starting_index = build_crates
    perform_instructions(instructions_starting_index)

    puts self.crates
  end

  def build_crates
    input.each_with_index do |line, idx|
      if line.include?('1')
        puts "begin instructions at index #{idx+1}"
        return idx+1
      else
        parsed_line = line.gsub(/\s\s\s/, '[')

        crate_idx = 0
        parsed_line.chars.each_with_index do |char|
          if char == ' ' || char == ']'
            next
          elsif char == '['
            crate_idx += 1
          else
            if crates[crate_idx].nil?
              crates[crate_idx] = []
            end

            crates[crate_idx].unshift(char)
          end
          puts "char: #{char}, crate_idx: #{crate_idx}"
        end
      end
    end
  end

  def perform_instructions(starting_index)
    puts self.crates
    input.each_with_index do |line, idx|
      next if idx <= starting_index

      parsed_line = line.gsub(/\D/, '')
      count, from, to = parsed_line.chars
      move(count.to_i, from.to_i, to.to_i)
    end
  end

  def move(count, from, to)
    puts "move #{count} from #{from} to #{to}"

    movable_list = crates[from].pop(count)

    movable_list.each do |crate|
      puts crate
      crates[to].push crate
    end
  end
end

ss = SupplyStacks.new