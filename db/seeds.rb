# BUILD seeds/books.json

### OLIDS pulled from https://openlibrary.org/people/Amiziras/lists/OL29869L/Various ###
#
# book_olids = [
#   'OL24950658M','OL8673330M','OL5982830M','OL6505223M','OL24400689M','OL24401637M','OL6273465M','OL24279433M','OL22985694M','OL6701695M',
#   'OL6199647M','OL6734490M','OL6178349M','OL6112008M','OL14123871M','OL24200709M','OL24209879M','OL6176551M','OL6439477M','OL14055842M',
#   'OL5801653M','OL6522174M','OL6725965M','OL6221211M','OL6272639M','OL5885122M','OL6247969M','OL6685005M','OL16271262M','OL5812293M',
#   'OL24220588M','OL6202631M','OL6359294M','OL6108307M','OL24210189M','OL6441430M','OL6733078M','OL6502149M','OL6443707M','OL6196283M',
#   'OL5903873M','OL5886522M','OL982866M','OL6112502M','OL6346061M','OL24200359M','OL6151137M','OL6499140M','OL6045280M','OL15340781M','OL6201769M'
# ]
#

### Create json file from openlibrary json API ###
#
# File.open('seeds/books.json', 'w') do |f|
#   f.puts '['
#   book_olids.each do |book_olid|
#     book_data = `curl 'https://openlibrary.org/api/books?bibkeys=OLID:#{book_olid}&format=json&jscmd=data'`
#     f.write book_data
#     f.puts ',' unless book_olid == book_olids.last
#   end
#   f.puts ']'
# end
#

# PARSE JSON and generate Books
File.open('db/seeds/books.json', 'r') do |f|
  books_json   = f.read
  parsed_books = JSON.parse(books_json).
                      map { |book| Hashie::Mash.new(book.values.first) }

  parsed_books.each do |parsed_book|
    book = Book.create!(title: parsed_book.title,
                        number_of_pages: parsed_book.number_of_pages,
                        publish_date: parsed_book.published_date,
                        coverimage: parsed_book.cover.try(:medium))

    if authors = parsed_book.authors
      authors.each do |author|
        book.authors << Author.find_or_create_by!(name: author.name)
      end
    end

    if subjects = parsed_book.subjects
      subjects.each do |subject|
        book.subjects << Subject.find_or_create_by!(name: subject.name)
      end
    end
  end
end
