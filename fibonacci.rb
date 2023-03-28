# frozen_string_literal: true

# Fibonacci Sequence, using iteration
def fibs(num)
  return unless num.positive?

  sequence = [0, 1]

  return [0] if num == 1

  return sequence if num == 2

  i = 0
  while sequence.length < num
    sequence << sequence[i] + sequence[i + 1]
    i += 1
  end

  sequence
end

# Fibonacci Sequence, using recursion
def fibs_rec(num, i = 0, sequence = [])
  return sequence if sequence.length == num

  sequence << ( i < 2 ? i : sequence[i - 1] + sequence[i - 2] )

  fibs_rec(num, i += 1, sequence)
end

p fibs(8)
puts
p fibs_rec(8)
