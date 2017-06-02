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
  if tovar == 'stop'
  	break
  else
  	puts 'enter price:'
    price = gets.chomp.to_f
    puts 'enter count:'
    count = gets.chomp.to_f
    prcnt = {:price => price, :count => count }
    shop[tovar.to_sym] = prcnt
  end
end
total = 0.0
shop.each do |tovar, value|
	tmpCost = value[:price]*value[:count]
  	puts "Total by #{tovar.to_s}: " + tmpCost.to_s + " rub"
  	total += tmpCost
end
puts "Ypu bought at #{total} rub"