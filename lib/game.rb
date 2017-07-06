require 'unicode'
# encoding: utf-8
#
# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
#
# За основу взяты методы из первой версии этой игры (подробные комментарии
# смотрите в прошлых уроках).
class Game
  attr_reader :status, :errors, :letters, :good_letters, :bad_letters

  # Конструктор — вызывается всегда при создании объекта данного класса имеет
  # один параметр, в него нужно передавать при создании строку к загаданнмы
  # словом. Например, game = Game.new('молоко').
  def initialize(word)

    # Переводим слово в нижний регистр
    word = Unicode::downcase(word)

    # Инициализируем переменные экземпляра. В @letters будет лежать массив букв
    # загаданного слова. Для того, чтобы его создать, вызываем метод get_letters
    # этого же класса.
    @letters = get_letters(word)

    # Переменная @errors будет хранить текущее количество ошибок, всего можно
    # сделать не более 7 ошибок. Начальное значение — 0.
    @errors = 0

    # Переменные @good_letters и @bad_lettes будут содержать массивы, хранящие
    # угаданные и неугаданные буквы. В начале игры они пустые.
    @good_letters = []
    @bad_letters = []

    # Специальная переменная-индикатор состояния игры (см. метод get_status)
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(word)
    if word == nil || word == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    word.encode('UTF-8').split("")
  end

  # Основной метод игры "сделать следующий шаг". В качестве параметра принимает
  # букву, которую ввел пользователь. Основная логика взята из метода
  # check_user_input (см. первую версию программы).
  def next_step(bukva)
    # Предварительная проверка: если статус игры равен 1 или -1, значит игра
    # закончена и нет смысла дальше делать шаг. Выходим из метода возвращая
    # пустое значение.
    if @status == -1 || @status == 1
      return
    end

    # Переводим слово в нижний регистр
    bukva = Unicode::downcase(bukva)

    # Если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выходим из метода.
    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    check_bukva_include = @letters.include?(bukva) ||
        (bukva == "е" && @letters.include?("ё")) ||
        (bukva == "ё" && @letters.include?("е")) ||
        (bukva == "и" && @letters.include?("й")) ||
        (bukva == "й" && @letters.include?("и"))

    if check_bukva_include
      # Если в слове есть буква запишем её в число "правильных" буква
      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      elsif bukva == "ё"
        @good_letters << "е"
      elsif bukva == "и"
        @good_letters << "й"
      elsif bukva == "й"
        @good_letters << "и"
      end

      # Дополнительная проверка — угадано ли на этой букве все слово целиком.
      # Если да — меняем значение переменной @status на 1 — победа.
      if (@letters.uniq - @good_letters).empty?
        @status = 1
      end
    else
      # Если в слове нет введенной буквы — добавляем эту букву в массив
      # «плохих» букв и увеличиваем счетчик ошибок.
      @bad_letters << bukva

      if bukva == "е"
        @bad_letters << "ё"
      elsif bukva == "ё"
        @bad_letters << "е"
      elsif bukva == "и"
        @bad_letters << "й"
      elsif bukva == "й"
        @bad_letters << "и"
      end

      @errors += 1

      # Если ошибок больше 7 — статус игры меняем на -1, проигрыш.
      if @errors >= 7
        @status = -1
      end
    end
  end
end
