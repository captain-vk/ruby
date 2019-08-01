i = 0
index = 0
arr = [1]

while arr.last < 100
  index = arr[i] + arr[i - 1]
  i += 1
  arr.push(index)
end

arr.delete_at(arr.size - 1)
puts arr
