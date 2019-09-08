require 'yaml'
require 'date'

class User
  attr_accessor :data, :account

  def initialize
    @data = load_data
    @account = []
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
    search = data.select { |book| book[:item][:title].include? search_str}
    search.each { |book| puts book[:item][:title] }
    # TODO: Copy into Library class
  end

  def search_for_book_author(search_str)
    puts data.select { |book| book[:item][:author].include? search_str}
    # TODO: Fix output and put into Library class
  end

  def checkout(title, author)
    
    (0...data.length).each do |book|
      transaction_success = false
      if (data[book][:item][:author] == author) && (data[book][:item][:title] == title)
        if data[book][:available] == true
          data[book][:available] = false
          data[book][:return_date] = calculate_return_date
          transaction_success = true
          write_to_account(data[book][:item][:title], data[book][:item][:author], calculate_return_date)
        end
      end
      write_changes
      return transaction_success
    end
    
  end

  def display_account
    return_strings = []
    (0...account.length).each do |book| 
      return_strings << "#{account[book][:title]} : #{account[book][:author]} : return by #{account[book][:return_date]}"
    end
    return return_strings
  end

  private
  def load_data
    YAML.load_file('lib/data.yml')
  end

  def calculate_return_date
    String(Date.today + 30)
  end

  def write_changes
    File.open('./lib/data.yml', 'w') {|book| book.write data.to_yaml}
  end

  def write_to_account(book_title, book_author, date)
    account << {title: book_title, author: book_author, return_date: date}
  end

end