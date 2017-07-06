# encoding: utf-8
#
# Популярная детская игра
# https://ru.wikipedia.org/wiki/Виселица_(игра)
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем классы Game, ResultPrinter и WordReader
require_relative "lib/game"
require_relative "lib/result_printer"
require_relative "lib/word_reader"

puts "Игра виселица. Версия 3. (c) goodprogrammer.ru\n\n"
sleep 1

printer = ResultPrinter.new

# Создаем экземпляр класса Word который мы будет использовать для
# вывода информации на экран.
word_reader = WordReader.new

# Соберем путь к файлу со словами из пути к файлу, где лежит программа и
# относительно пути к файлу words.txt.
words_file_name = File.dirname(__FILE__) + "/data/words.txt"

# Создаем объект класса Game, вызывая конструктор и передавая ему слово, которое
# вернет метод read_from_file экземпляра класса WordReader.
word = word_reader.read_from_file(words_file_name)
game = Game.new(word)

while game.status == 0
  printer.print_status(game)
  letter = ""
  while letter == "" || letter.length > 1
    puts "\nВведите следующую букву"
    letter = STDIN.gets.encode("UTF-8").chomp
  end

  # После получения ввода, передаем управление в основной метод игры
  game.next_step(letter)
end

printer.print_status(game)
