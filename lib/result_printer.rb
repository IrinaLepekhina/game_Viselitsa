# frozen_string_literal: true

# Класс ResultPrinter, печатающий состояние и результаты игры.
class ResultPrinter
  def initialize(game)
    @status_image = []
    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= game.max_errors
      file_name = current_path + "/../image/#{counter}.txt"
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
    # cls

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.lost?
      puts 'Вы проиграли'
    elsif game.won?
      puts 'Поздравляем, вы выиграли!'
    else
      puts "У вас осталось попыток: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |letter|
      result += if good_letters.include?(letter)
                  "#{letter} "
                else
                  '__ '
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
