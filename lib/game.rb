# frozen_string_literal: true

# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
class Game
  attr_accessor :letters, :good_letters, :bad_letters, :errors, :status

  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @good_letters = []
    @bad_letters = []
    @errors = 0
    @status = :in_progress
    # :in_progress — игра продолжается
    # :won — игра выиграна
    # :lost — игра проиграна
  end

  def get_letters(slovo)
    abort 'для игры введите слово при запуске программы' if [nil, ''].include?(slovo)

    slovo.encode('UTF-8').split('')
    # UnicodeUtils.upcase(slovo).split('')
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def good?(letter)
    @letters.include?(letter) ||
      (letter == 'Е' && @letters.include?('Ё')) ||
      (letter == 'Ё' && @letters.include?('Е')) ||
      (letter == 'И' && @letters.include?('Й')) ||
      (letter == 'Й' && @letters.include?('И'))
  end

  def add_letter_to(list, letter)
    list << letter

    case letter
    when 'И' then letters << 'Й'
    when 'Й' then letters << 'И'
    when 'Е' then letters << 'Ё'
    when 'Ё' then letters << 'Е'
    end
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def won?
    @status == :won
  end

  def in_progress?
    @status == :in_progress
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def ask_next_letter
    puts 'введите следующую букву'

    letter = ''

    letter = $stdin.gets.encode('UTF-8').chomp while letter == ''

    next_step(letter)
  end

  def next_step(letter)
    # letter = UnicodeUtils.upcase(letter)

    return if @status == :lost || @status == :won

    return if repeated?(letter)

    if good?(letter)
      add_letter_to(@good_letters, letter)
      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = :lost if lost?
    end
  end
end
