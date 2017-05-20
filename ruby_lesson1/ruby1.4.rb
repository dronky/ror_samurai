#Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если
#oни есть) и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
#  Если D > 0, то выводим дискриминант и 2 корня
#  Если D = 0, то выводим дискриминант и 1 корень (т.к. они в этом случае равны)
#  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
#Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать  
#Math.sqrt
# Например,  
#Math.sqrt(16)
#  вернет 4, т.е. квадратный корень из 16.

puts "Enter a b c (with delimiter ','):"
coefficients = gets.chomp.split(',').map(&:to_f)
d = coefficients[1]**2-4*coefficients[0]*coefficients[2]
if d == 0
	x  = -coefficients[1]/(2*coefficients[0])
	puts "x = #{x}"
elsif d < 0
	puts "no roots of equation"
elsif d > 0
	x1 = -(coefficients[1]+Math.sqrt(d))/(2*coefficients[0])
	x2 = -(coefficients[1]-Math.sqrt(d))/(2*coefficients[0])
	puts "x1 = #{x1}"
	puts "x2 = #{x2}"
end