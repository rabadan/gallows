# encoding: utf-8
#
# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  # Так как, подобно классу ResultPrinter, экземляр этого класса не хранит
  # в себе никаких данных, конструктор отсутствует.

  # Сохраним старую возможность читать слово из аргументов командной строки. В
  # качестве отедльного метода read_from_args для обратной совместимости.
  def read_from_args
    ARGV[0].chomp
  end

  # Метод read_from_file, возвращающий случайное слово, прочитанное из файла,
  # имя которого нужно передать методу в качестве единственного аргумента.
  def read_from_file(file_name)
    # Если файла не существует, выходим из программы
    abort "Файл не найден: #{file_name}" unless File.exist?(file_name)

    # Открываем файл, явно указывая его кодировку, читаем все строки в массив и
    # закрываем файл.
    begin
      file = File.new(file_name, "r:UTF-8")
      line = file.readlines.sample.chomp
      file.close
    rescue SystemCallError
      abort "Не удается открыть файл: #{file_name}"
    end

    # Возвращаем случайную строчку
    line
  end
end
