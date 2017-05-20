# Идеальный вес. Программа запрашивает у пользователя
#  имя и рост и выводит идеальный вес по формуле
#  <рост> - 110, после чего выводит результат пользователю на экран
#  с обращением по имени. Если идеальный вес получается отрицательным,
#  то выводится строка "Ваш вес уже оптимальный"
puts 'Hello. Let me know your name'
name = gets.chomp
puts 'Fine, now i want to know your height'
height = gets.chomp.to_f
best_weight = height - 110
if best_weight > 0
	puts "Ok, #{name}, yor best weight is #{best_weight}"
else 
	puts "Ok, #{name}, your weight is good"
end