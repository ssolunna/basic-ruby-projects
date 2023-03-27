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

p fibs(8)
