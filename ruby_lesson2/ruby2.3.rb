#Заполнить массив числами фибоначчи до 100
arr = [0,1]
while arr[-1] + arr[-2] <= 100
	arr << (arr[-1] + arr[-2])
end
puts arr