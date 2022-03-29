todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

categories = []
todos.each do |todo|
  ct = categories.find { |category| category == todo.last }
  if ct == nil
    categories.push(todo.last)
  end
end

categories.each do |category|
  items = todos.select { |todo| todo.last == category }.map { |todo| todo.first }
  puts "#{category}:"
  puts "\t#{items.join("\n\t")}"
end
