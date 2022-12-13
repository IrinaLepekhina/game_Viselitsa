# frozen_string_literal: true

# top-level documentation comment
class Game
  attr_accessor :letters, :good_letters, :bad_letters, :errors, :status

  def initialize(slovo)
    @letters = get_letters(slovo)

    @good_letters = []
    @bad_letters = []
    @errors  = 0
    @status  = 0
  end

  def get_letters(slovo)
    abort 'для игры введите слово при запуске программы' if [nil, ''].include?(slovo)

    slovo.encode('UTF-8').split('')
  end

  def ask_next_letter
    puts 'введите следующую букву'

    letter = ''

    letter = $stdin.gets.encode('UTF-8').chomp while letter == ''

    next_step(letter)
  end

  def next_step(bukva)
    return if @status == -1 || @status == 1

    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if @letters.include?(bukva)
      @good_letters << bukva
      @status = 1 if @letters.uniq.size == @good_letters.size
    else
      @bad_letters << bukva
      @errors += 1

      @status = -1 if @errors >= 7
    end
  end
end