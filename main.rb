# frozen_string_literal: true

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

require "#{current_path}/lib/game.rb"
require "#{current_path}/lib/result_printer.rb"
require "#{current_path}/lib/word_reader.rb"
require "#{current_path}/lib/exeption.rb"

reader = WordReader.new
word = reader.read_from_files("#{current_path}/data/words.txt")

game = Game.new(word)
printer = ResultPrinter.new(game)

puts 'Игра виселица. Версия 3.'
sleep 1

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
