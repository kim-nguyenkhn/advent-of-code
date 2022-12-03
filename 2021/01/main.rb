is_increasing_count = 0
current_number = 0
previous_number = 0

IO.readlines('input.txt').each_with_index do |line, idx|
    if idx == 0
        previous_number = line.to_i
        next
    end

    if line.to_i > previous_number
        is_increasing_count += 1
    end

    previous_number = line.to_i
end

puts is_increasing_count