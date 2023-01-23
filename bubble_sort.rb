def bubble_sort(array)
  loop do
    array.each_with_index.reduce() do |prev_num_and_index, next_num_and_index|
      prev_num = prev_num_and_index[0]
      next_num = next_num_and_index[0]
      prev_num_position = prev_num_and_index[1]
      next_num_position = next_num_and_index[1]

      if prev_num > next_num
        array.insert(next_num_position, array.delete_at(prev_num_position))
      end

      [array[next_num_position], next_num_position]
    end

    break if sorted?(array)
  end

  array
end

def sorted?(array)
  sorted = true
  arr = array.rotate(0) # Copy of the array

  array.each do |prev_num|
    unless arr.all? { |next_num| prev_num <= next_num }
      sorted = false
      break
    end
    arr.shift
  end

  sorted
end

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([-1,4,3,78,2,0,2,79])