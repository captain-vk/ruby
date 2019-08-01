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
  basket[name] = {price => number}
end
puts basket
basket.each do |name, cost|
  cost.each do |i,j|
    cost_goods = i * j
    puts "#{name} cost #{cost_goods}"
    all_price += cost_goods
    end
end

puts "Total price: #{all_price}"
