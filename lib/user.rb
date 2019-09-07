
class User
  attr_accessor :data

  def initialize
    @data = load_data
  end

  def find_available_books
    available_books = []

    (0...data.length).each do |book|
      if data[book][:available] == true
        available_books << data[book]
      end
    end
    return available_books
  end

  def see_available_books
    available_books = find_available_books
    
    (0...available_books.length).each do |book|
      puts available_books[book][:item][:author] + ' : ' +  available_books[book][:item][:title]
      #print available_books[book][:item][:author] + ' : ' +  available_books[book][:item][:title] + '\n'
    end

  end

  private
  def load_data
    YAML.load_file('lib/data.yml')
  end
end