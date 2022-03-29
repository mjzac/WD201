books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]
books.map.with_index { |book, i| puts "#{book} was written by #{authors[i]}" }
