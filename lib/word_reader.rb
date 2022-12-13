# frozen_string_literal: true

# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  def read_from_files(file_name)
    f = File.new(file_name, 'r:UTF-8')
    lines = f.readlines
    f.close
    lines.sample.chomp
  rescue SystemCallError => e
    puts e.message
    raise OpenException, 'No file'

    ### поправить обработку ошибок
  end
end
