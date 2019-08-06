basket = {}
all_price = 0
cost_goods = 0
puts "Введите Стоп в Название товара для останова"
puts "==========================================="
loop do
  puts "Название товара"
  name = gets.chomp
  break if name == 'Стоп'
  puts "Цена за единицу"
  price = gets.chomp.to_f
  puts "Кол-во"
  number = gets.chomp.to_f
  basket[name] = {price: price, number: number, cost_goods: price * number}
end
puts basket

basket.each_value do |cost|
  all_price += cost[:cost_goods]
end

puts "Total price: #{all_price}"
