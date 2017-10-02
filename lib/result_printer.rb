# encoding: utf-8
#
# Класс ResultPrinter, печатающий состояние и результаты игры. В этой версии
# игры мы будем считывать картинки каждого из состояний виселицы из файлов в
# папке image.
class ResultPrinter
  def initialize(game)
    @status_image = []

    (game.max_errors+1).times do |counter|
      @status_image << load_status_img(counter)
    end
  end

  def load_status_img(counter)
    file_name = File.dirname(__FILE__) + "/../image/#{counter}.txt"

    if File.exist?(file_name)
      f = File.new(file_name, 'r:UTF-8')
      result = f.read
      f.close
    else
      result = "\n [ изображение не найдено ] \n"
    end

    result
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  # Основной метод, печатающий состояния объекта класса Game, который нужно
  # передать ему в качестве параметра.
  def print_status(game)
    cls
    puts game.version
    puts
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.lost?
      puts "\nВы проиграли :(\n"
      puts 'Загаданное слово было: ' + game.letters.join('')
      puts
    elsif game.won?
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |letter|
      result += if good_letters.include?(letter)
                  letter + ' '
                else
                  '__ '
                end
    end

    result
  end

  def cls
    system('clear') || system('cls')
  end
end
