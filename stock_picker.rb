def stock_picker(array)
  best_profit = 0
  profit_days = []
  stock_prices = []
  array.each { |e| stock_prices << e }

  until array.empty?
    buy_price = array[0]

    array.each do |sell_price|
      current_profit = sell_price - buy_price
  
      if current_profit > best_profit
        best_profit = current_profit
        profit_days = [stock_prices.index(buy_price), stock_prices.index(sell_price)]
      end
    end

    array.delete_at(0)
  end

  profit_days
end

p stock_picker([17,3,6,9,15,8,6,1,10])