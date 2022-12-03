sliding_window_increase_count = 0
previous_sliding_sum = 0

input_list = IO.readlines('input.txt').map {|line| line.to_i}

input_list.each_with_index do |line, idx|
    next if idx < 3

    current_sliding_sum = input_list[idx] +
        input_list[idx - 1] +
        input_list[idx - 2]
    previous_sliding_sum = input_list[idx - 1] +
        input_list[idx - 2] +
        input_list[idx - 3]

    if current_sliding_sum > previous_sliding_sum
        sliding_window_increase_count += 1
    end
end

puts sliding_window_increase_count