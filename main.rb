# frozen_string_literal: true

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

require "#{current_path}/game.rb"
require "#{current_path}/resultprinter.rb"
require "#{current_path}/word_reader.rb"


begin
  reader = WordReader.new
  slovo = reader.read_from_files("#{current_path}/data/words.txt")
rescue OpenException
  abort 'Файл со словами не найден!'
end

game = Game.new(slovo)
printer = ResultPrinter.new

puts 'Игра виселица. Версия 3.'
sleep 1

while game.status.zero?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)