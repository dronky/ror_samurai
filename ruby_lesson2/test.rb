cart = {}
sums = []
full_sum = 0

loop do
	puts "Введите 'стоп', чтобы прервать цикл:"
	puts "Введите название товара."
	title = gets.chomp
	if title == "stop"
		sums.each{|s| full_sum += s}
		puts "Ваш заказ #{cart}"
		puts "Общая сумма покупки — #{full_sum}"
		break
	end
	puts "Введите цену за единицу товара:"
	price = gets.chomp
	puts "Введите кол-во товара:"
	count = gets.chomp
	sum = price.to_f * count.to_f
	sums << sum
	cart.store(title, {price.to_sym => count})
end