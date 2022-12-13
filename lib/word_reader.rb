# frozen_string_literal: true

# top-level documentation comment
class WordReader
  def read_from_files(file_name)
    file = File.new(file_name, 'r:UTF-8')
    lines = file.readlines
    file.close
    lines.sample.chomp
  rescue SystemCallError => e
    #puts e.message
    raise OpenException
  end
end