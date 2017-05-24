#6. Сумма покупок. Пользователь вводит поочередно название товара,
#цену за единицу и кол-во купленного товара (может быть нецелым числом). 
#Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. 
#На основе введенных данных требуетеся:
#Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
#содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
#Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

#Повторяющийся товар будет перезаписан

shop = {}
loop do
  puts 'enter product or "stop":'
  tovar = gets.chomp
  break if tovar == 'stop'
  if shop.has_key?(tovar.to_sym)
  	puts "are you sure want to change price/count of #{tovar}? y/n(default - no)" 
	next if gets.chomp == 'n'
  end
  puts 'enter price:'
  price = gets.chomp.to_f
  puts 'enter count:'
  count = gets.chomp.to_f
  shop[tovar.to_sym] = {price: price, count: count }
end
total = 0.0
shop.each do |tovar, value|
	tmp_cost = value[:price]*value[:count]
  	puts "Total by #{tovar}: " + tmp_cost.to_s + " rub"
  	total += tmp_cost
end
puts "Ypu bought at #{total} rub"