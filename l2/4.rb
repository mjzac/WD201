books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]

library = {}

books.map.with_index do |book, i|
  author = authors[i].downcase.split().first.to_sym
  library[author] = book
end
puts library

todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

library = {}
todos.each do |todo|
  key = todo.last.downcase.to_sym
  if library[key] == nil
    library[key] = [todo.first]
  else
    library[key].push(todo.first)
  end
end
puts library
