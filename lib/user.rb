require 'yaml'

class User
  attr_accessor :data

  def initialize
    @data = load_data
  end

  def see_available_books
    # TODO: Update same method in Library class
    available_books = []

    (0...data.length).each do |book|
      if data[book][:available] == true
        available_books << data[book]
      end
    end
    
    (0...available_books.length).each do |book|
      puts available_books[book][:item][:author] + ' : ' +  available_books[book][:item][:title]
    end
  end

  def search_for_book_title(search_str)
    puts data.select { |book| book[:item][:title].include? search_str}
    # TODO: Fix output and put into Library class
  end

  def search_for_book_author(search_str)
    puts data.select { |book| book[:item][:author].include? search_str}
    # TODO: Fix output and put into Library class
  end

  def checkout
    # TODO: Finish process
  end

  private
  def load_data
    YAML.load_file('lib/data.yml')
  end
end