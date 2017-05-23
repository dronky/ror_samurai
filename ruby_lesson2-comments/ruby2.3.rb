#Заполнить массив числами фибоначчи до 100
arr = [1,1]
i=2
while arr[-1] + arr[-2] <= 100
	arr << (arr[i-1] + arr[i-2])
	i+=1
end
puts arr