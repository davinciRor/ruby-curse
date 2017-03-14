require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require 'pry'


class Main
  attr_reader :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def text_ui
    loop do
      action = choose_action
      break if action == 0
      case action
      when 1
        create_station
      when 2
        create_train
      when 3
        add_carriage
      when 4
        remove_carriage
      when 5
        add_train_to_station
      when 6
        trains_on_station
      else
        puts "Не верный выбор"
      end
      puts "Введите следующее действие"
    end
  end

  private

  attr_writer :stations, :trains

  def trains_on_station
    station = choose_station
    return puts "Нет такой станции" unless station
    puts "Список поездов на станции #{station.name}: #{station.trains_list}"
  end

  def add_train_to_station
    station = choose_station
    return puts "Нет такой станции" unless station
    train = choose_train
    return puts "Нет такого поезда" unless train
    station.add_train(train)
    puts "Поезд #{train.number} успешно добавлен на станцию #{station.name}!"
  end

  def choose_station
    puts "Список станций: #{stations_list}"
    puts "Введите имя станции"
    station_name = gets.chomp
    station_by_name(station_name)
  end

  def stations_list
    self.stations.map(&:name).join(' ')
  end

  def station_by_name(name)
    self.stations.select{ |station| station.name == name }.first
  end

  def remove_carriage
    train = choose_train
    if train.remove_carriage
      puts 'Вагон успешно отцеплен'
    else
      puts 'В поезде нет вагонов'
    end
  end

  def add_carriage
    train = choose_train
    if train
      case train.type
      when :passenger
        train.add_carriage(PassengerCarriage.new)
      when :cargo
        train.add_carriage(CargoCarriage.new)
      end
      puts "Вагон успешно добавлен!"
    else
      puts "Поезд не найден"
    end
  end

  def choose_train
    puts "Список поездов: #{trains_list}"
    puts "Введите номер поезда"
    train_number = gets.chomp
    train_by_number(train_number)
  end

  def train_by_number(number)
    Train.find(number)
  end

  def create_train
    puts %q(Введите тип поезда который хотите создать!
      1 - Пасажирский
      2 - Товарный
    )
    train_type = gets.chomp.to_i
    puts "Введите номер поезда"
    train_number = gets.chomp
    case train_type
    when 1
      self.trains << PassengerTrain.new(train_number)
      puts "Пасажирский поезд успешно создан c номером #{train_number}!"
    when 2
      self.trains << CargoTrain.new(train_number)
      puts "Грузовой поезд успешно создан c номером #{train_number}!"
    else
      "Не верный выбор"
    end
  end

  def create_station
    puts "Введите имя станции!"
    station_name = gets.chomp
    self.stations << Station.new(station_name)
    puts "Станция #{station_name} успешно создана!"
  end

  def trains_list(type = nil)
    if type
      self.trains.map{ |t| t.number if t.type == type }.compact.join(' ')
    else
      self.trains.map(&:number).join(' ')
    end
  end

  def choose_action
    puts %Q(
Список действий
0 - Выход
1 - Создавать станции
2 - Создавать поезда
3 - Добавлять вагоны к поезду
4 - Отцеплять вагоны от поезда
5 - Помещать поезда на станцию
6 - Просматривать список станций и список поездов на станции
ВВЕДИТЕ НОМЕР:)
    gets.chomp.to_i
  end
end

Main.new.text_ui
