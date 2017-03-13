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
  attr_accessor :stations, :cargo_trains, :passenger_trains

  def initialize
    @stations = []
    @cargo_trains = []
    @passenger_trains = []
  end

  def passenger_trains_list
    self.passenger_trains.map(&:number).join(' ')
  end

  def cargo_trains_list
    self.cargo_trains.map(&:number).join(' ')
  end

  def text_ui
    loop do
      puts %Q(

Список действий
0 - Выход
1 - Создавать станции
2 - Создавать поезда
3 - Добавлять вагоны к поезду
4 - Отцеплять вагоны от поезда
5 - Помещать поезда на станцию
6 - Просматривать список станций и список поездов на станции

ВВЕДИТЕ НОМЕР:
    )

      input = gets.chomp.to_i
      break if input == 0

      case input
      when 1
        puts "Введите имя станции!"
        station_name = gets.chomp
        self.stations << Station.new(station_name)
        puts "Станция #{station_name} успешно создана!"
      when 2
        puts %q(Введите тип поезда который хотите создать!
          1 - Пасажирский
          2 - Товарный
        )
        train_type = gets.chomp.to_i
        puts "Введите номер поезда"
        train_number = gets.chomp
        case train_type
        when 1
          train = PassengerTrain.new(train_number)
          self.passenger_trains << train
          puts "Пасажирский поезд успешно создан c номером #{train_number}!"
        when 2
          train = CargoTrain.new(train_number)
          self.cargo_trains << train
          puts "Грузовой поезд успешно создан c номером #{train_number}!"
        else
          "Не верный выбор"
        end
      when 3
        puts %q(Введите тип поезда к которому хотите добавить вагон!
          1 - Пасажирский
          2 - Товарный
        )
        train_type = gets.chomp.to_i
        case train_type
        when 1
          puts 'Вы выбрали пасажирские поезд'
          puts "Список: #{passenger_trains_list}"
          puts "Введите номер поезда к которому хотите добавить вагон"
          train_number = gets.chomp
          _passenger_trains = self.passenger_trains.select { |train| train.number == train_number }
          if _passenger_trains.any?
            _passenger_trains.first.add_carriage(PassengerCarriage.new)
            puts "В пасажирский поезд с номером #{train_number} успешно добавлен вагон"
          else
            "Нет такого поезда"
          end
        when 2
          puts 'Вы выбрали грузовой поезд'
          puts "Список: #{cargo_trains_list}"
          puts "Введите номер поезда к которому хотите добавить вагон"
          train_number = gets.chomp
          _cargo_trains = self.cargo_trains.select { |train| train.number == train_number }
          if _cargo_trains.any?
            _cargo_trains.first.add_carriage(CargoCarriage.new)
            puts "В грузовой поезд с номером #{train_number} успешно добавлен вагон"
          else
            "Нет такого поезда"
          end
        else
          'Нет такого типа'
        end
      when 4
        puts %q(Введите тип поезда от которого хотите отцепить вагон!
          1 - Пасажирский
          2 - Товарный
        )
        train_type = gets.chomp.to_i
        case train_type
        when 1
          puts 'Вы выбрали пасажирские поезд'
          puts "Список: #{passenger_trains_list}"
          puts "Введите номер поезда от которого отцепить вагон"
          train_number = gets.chomp
          _passenger_trains = self.passenger_trains.select { |train| train.number == train_number }
          if _passenger_trains.any?
            _passenger_trains.first.remove_carriage
            puts "От пасажирский поезда с номером #{train_number} успешно отцеплен вагон"
          else
            "Нет такого поезда"
          end
        when 2
          puts 'Вы выбрали пасажирские поезд'
          puts "Список: #{cargo_trains_list}"
          puts "Введите номер поезда от которого отцепить вагон"
          train_number = gets.chomp
          _cargo_trains = self.cargo_trains.select { |train| train.number == train_number }
          if _cargo_trains.any?
            _cargo_trains.first.remove_carriage
            puts "От грузового поезда с номером #{train_number} успешно отцеплен вагон"
          else
            puts "Нет такого поезда"
          end
        else
          puts 'Нет такого типа'
        end
      when 5
        puts "Выберите станцию на которую хотите добавить поезд"
        puts "Список станций: #{self.stations.map(&:name).join(' ')}"
        station_name = gets.chomp
        _station = self.stations.select { |s| s.name == station_name }
        if _station.any?
          puts "Введите поезд который хотите добавить"
          _trains = (self.cargo_trains + self.passenger_trains)
          trains_list = _trains.map(&:number).join(' ')
          puts "Список: #{trains_list}"
          train_number = gets.chomp
          _train = _trains.select { |t| t.number == train_number }
          if _train.any?
            _station.first.add_train(_train.first)
            puts "Поезд #{_train.first.number} успешно добавлен на станцию #{_station.first.name}"
          else
            puts "Нет такого поезда"
          end
        else
          puts "Нет такой станции"
        end
      when 6
        puts "Выберите станцию"
        puts "Список станций: #{self.stations.map(&:name).join(' ')}"
        station_name = gets.chomp
        _station = self.stations.select { |s| s.name == station_name }
        if _station.any?
          station = _station.first
          puts "Список поездов на станции #{station.name}"
          puts station.trains.map(&:number).join(' ')
        else
          puts "Нет такой станции"
        end
      else
        puts "Не верный выбор"
      end
      puts "Введите следующее действие"
    end
  end
end

Main.new.text_ui
