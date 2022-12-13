# frozen_string_literal: true

# top-level documentation comment
class ResultPrinter
  def initialize
    @status_image = []
    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= 7
      file_name = current_path + "/image/#{counter}.txt"
      begin
        f = File.new(file_name, 'r:UTF-8')
        @status_image << f.read
        f.close
      rescue SystemCallError
        @status_image << "\n[ Изображение не найдено ]\n" # exeption
      end

      counter += 1
    end
  end

  def print_status(game)
    cls

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.errors >= 7
      puts 'Вы проиграли'
    elsif game.letters.uniq.size == game.good_letters.uniq.size
      puts 'Поздравляем, вы выиграли!'
    else
      puts "У вас осталось попыток: #{7 - game.errors}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |item|
      result += if good_letters.include?(item)
                  "#{item} "
                elsif (good_letters.include?('е') && item == 'ё') || (good_letters.include?('ё') && item == 'е')
                  'ёе '
                elsif (good_letters.include?('и') && item == 'й') || (good_letters.include?('й') && item == 'и')
                  'ий '
                else
                  ' _ '
                end
    end

    result
  end

  def cls
    system('clear') || system('cls')
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end
end