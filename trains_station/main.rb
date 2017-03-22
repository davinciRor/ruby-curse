require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require 'pry'

# Text UI
class Main
  ACTIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :add_carriage,
    4 => :remove_station,
    5 => :add_train_to_station,
    6 => :trains_on_station,
    7 => :take_place_or_volume
  }
  attr_reader :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def text_ui
    loop do
      action = choose_action
      break if action.zero?
      self.send(ACTIONS[action]) rescue puts 'Не правильно введен номер'
      puts 'Введите следующее действие'
    end
  end

  def test_data
    s1 = Station.new('s1')
    t1 = PassengerTrain.new('333-dd')
    t2 = CargoTrain.new('443-dd')
    s2 = Station.new('s2')
    t3 = PassengerTrain.new('ddd-dd')
    t4 = CargoTrain.new('ccc-dd')
    10.times do |count|
      if count > 5
        t1.add_carriage(PassengerCarriage.new(4 * count, 'COMPANY_BELIVE'))
      else
        t2.add_carriage(CargoCarriage.new(100 * count, 'CARGOCOMPANY'))
      end
    end
    s1.add_train(t1)
    s1.add_train(t2)
    s2.add_train(t3)
    s2.add_train(t4)
    Station.all.each do |station|
      puts "#{station.name}: "
      station_info
    end
  end

  private

  attr_writer :stations, :trains

  def take_place_or_volume
    train = choose_train
    puts "Number: #{train.number}, Type: #{train.type}, Carriages: #{train.carriages.count}"
    i = 1
    train.each_carriage do |carriage|
      puts "#{i}: #{carriage.info}"
      i += 1
    end
    puts 'Choose carriage by number'
    carriage_index = gets.chomp.to_i
    carriage = train.carriages[carriage_index - 1]
    case carriage.type
    when :passenger
      carriage.take_a_seat
      puts 'Вы заняли 1 место'
    when :cargo
      puts "Введите обьем который хотите занять! Свободно: #{carriage.available_volume}"
      volume = gets.chomp.to_i
      if carriage.taken_volume(volume)
        puts "Вы заняли обьем #{volume}"
      else
        puts 'Вы не можете занять столько обьема'
      end
    end
  end

  def trains_on_station
    station = choose_station
    return puts 'Нет такой станции' unless station
    puts "Список поездов на станции #{station.name}:"
    station_info(station)
  end

  def station_info(station)
    station.each_train do |train|
      puts "Number: #{train.number}, Type: #{train.type}, Carriages: #{train.carriages.count}"
      i = 1
      train.each_carriage do |carriage|
        puts "#{i}: #{carriage.info}"
        i += 1
      end
    end
  end

  def add_train_to_station
    station = choose_station
    return puts 'Нет такой станции' unless station
    train = choose_train
    return puts 'Нет такого поезда' unless train
    station.add_train(train)
    puts "Поезд #{train.number} успешно добавлен на станцию #{station.name}!"
  end

  def choose_station
    puts "Список станций: #{stations_list}"
    puts 'Введите имя станции'
    station_name = gets.chomp
    station_by_name(station_name)
  end

  def stations_list
    stations.map(&:name).join(' ')
  end

  def station_by_name(name)
    stations.select { |station| station.name == name }.first
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
      puts 'Введите название компании'
      company_name = gets.chomp
      case train.type
      when :passenger
        puts 'Введите количество мест'
        seats = gets.chomp.to_i
        train.add_carriage(PassengerCarriage.new(seats, company_name))
      when :cargo
        puts 'Введите обьем'
        volume = gets.chomp.to_i
        train.add_carriage(CargoCarriage.new(volume, company_name))
      end
      puts 'Вагон успешно добавлен!'
    else
      puts 'Поезд не найден'
    end
  end

  def choose_train
    puts "Список поездов: #{trains_list}"
    puts 'Введите номер поезда'
    train_number = gets.chomp
    train_by_number(train_number)
  end

  def train_by_number(number)
    Train.find(number)
  end

  def create_train
    puts 'Введите тип поезда который хотите создать!
      1 - Пасажирский
      2 - Товарный
    '
    train_type = gets.chomp.to_i
    puts 'Введите номер поезда'
    train_number = gets.chomp
    case train_type
    when 1
      trains << PassengerTrain.new(train_number)
      puts "Пасажирский поезд успешно создан c номером #{train_number}!"
    when 2
      trains << CargoTrain.new(train_number)
      puts "Грузовой поезд успешно создан c номером #{train_number}!"
    else
      'Не верный выбор'
    end
  rescue => e
    puts e.message
    retry
  end

  def create_station
    puts 'Введите имя станции!'
    station_name = gets.chomp
    stations << Station.new(station_name)
    puts "Станция #{station_name} успешно создана!"
  end

  def trains_list(type = nil)
    if type
      trains.map { |t| t.number if t.type == type }.compact.join(' ')
    else
      trains.map(&:number).join(' ')
    end
  end

  def choose_action
    puts %(
Список действий
0 - Выход
1 - Создавать станции
2 - Создавать поезда
3 - Добавлять вагоны к поезду
4 - Отцеплять вагоны от поезда
5 - Помещать поезда на станцию
6 - Просматривать список станций и список поездов на станции
7 - Занять место или обьем в вагоне
ВВЕДИТЕ НОМЕР:)
    gets.chomp.to_i
  end
end
Main.new.text_ui
# Main.new.test_data
