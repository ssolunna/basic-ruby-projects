# frozen_string_literal: true

# Sorts an array using a recursive merge sort methodology
def merge_sort(array)
  return array if array.size == 1

  sorted_array = []
  array1 = merge_sort(array[0...(array.size / 2.0).round(half: :up)])
  array2 = merge_sort(array[(array.size / 2.0).round(half: :up)..])

  array1.each_with_object(sorted_array) do |num_array1, sorted_array|
    array2.each_with_index do |num_array2, index_array2|
      next if num_array2 == :x

      if num_array1 < num_array2
        sorted_array << num_array1
        break
      elsif num_array1 == num_array2
        array2.fill(:x, index_array2, 1)
        sorted_array << num_array1 && sorted_array << num_array2
        break
      elsif num_array1 > num_array2
        array2.fill(:x, index_array2, 1)
        sorted_array << num_array2
      end
    end

    sorted_array << num_array1 if array2.all? { |num_array2| num_array2.is_a?(Symbol) }
  end

  sorted_array << array2.find { |num_array2| num_array2.is_a?(Numeric) }

  sorted_array.compact
end

p merge_sort([1])
p merge_sort([74, 29])
p merge_sort([2.3, -2, 0])
p merge_sort([10, 7, 8, 1])
p merge_sort([4, 1, 3, 2, 5])
p merge_sort([9, 7, 8, 3, 2, 1])
