# What is the sum of the total sizes of those directories?

class NoSpaceLeftOnDevice
  attr_accessor :input, :directories, :pwd

  MAX_THRESHOLD = 100000

  def initialize(filepath)
    @input = IO.readlines(filepath)
    @directories = {}
    @pwd = ''
  end

  def main
    input.each do |line|
      # puts line

      if line.start_with?('$ cd ')
        target_dir = line.split('$ cd ').last.strip
        handle_cd(target_dir)
      elsif line.start_with?(/dir/)
        dir_name = line.split(' ').last
      elsif line.start_with?(/\d/)
        handle_size_value(line)
      end
    end

    puts directories

    find_sum_of_directory_total_sizes_under_max_threshold
  end

  # @param target_dir [String]
  def handle_cd(target_dir)
    if target_dir == '/'
      @pwd = '/'
    elsif target_dir == '..'
      @pwd = pwd.slice(0..-2)
    else
      @pwd += target_dir
    end

    create_dir_if_empty(pwd)
  end

  # @param dir [String]
  def create_dir_if_empty(dir)
    if directories[dir].nil?
      directories[dir] = {
        total_size: 0,
        files: []
      }
    end
  end

  # @param size [Integer]
  def handle_size_value(line)
    size, filename = line.split(' ')
    pointer = pwd


    until pointer.empty?
      create_dir_if_empty(pointer)

      keyname = "#{Time.now.to_i}-#{filename}"
      # TODO: only add if it hasn't already been added
      if !directories[pointer][:files].include?(keyname)
        directories[pointer][:total_size] += size.to_i
        directories[pointer][:files].push keyname
      end

      pointer = pointer.chop
    end
  end

  def find_sum_of_directory_total_sizes_under_max_threshold
    total_size = 0

    directories.values.each do |hash|
      if hash[:total_size] < MAX_THRESHOLD
        total_size += hash[:total_size]
      end
    end

    total_size
  end
end

n_test = NoSpaceLeftOnDevice.new('test.txt')
# puts n_test.main

n_input = NoSpaceLeftOnDevice.new('input.txt')
puts n_input.main