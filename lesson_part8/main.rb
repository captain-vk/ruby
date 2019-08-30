# frozen_string_literal: true

require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'company'

class Main
  attr_reader :stations, :trains, :routes, :passenger_wagons, :cargo_wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @passenger_wagons = []
    @cargo_wagons = []
  end

  def main_menu
    puts 'Нажмите 1 чтобы, создать станцию'
    puts 'Нажмите 2 чтобы, создать поезд'
    puts 'Нажмите 3 для управления вагонами'
    puts 'Нажмите 4 для создания маршрута'
    puts 'Нажмите 5 для добавления станции в маршруте'
    puts 'Нажмите 6 для удаления станции в маршруте'
    puts 'Нажмите 7 чтобы, назначить маршрут поезду'
    puts 'Нажмите 8 чтобы, добавлять вагоны к поезду'
    puts 'Нажмите 9 чтобы, отцеплять вагоны от поезда'
    puts 'Нажмите 10 чтобы, перемещать поезд по маршруту вперед и назад'
    puts 'Нажмите 11 чтобы, просматривать список станций и список поездов на станции'
    puts 'Нажмите 0 для выхода'
    input = gets.chomp.to_i

    case input
    when 1
      create_station
    when 2
      create_train
    when 3
      create_wagon
    when 4
      create_route
    when 5
      add_stations_on_route
    when 6
      delete_stations_on_route
    when 7
      set_route_to_train
    when 8
      add_wagon
    when 9
      delete_wagon
    when 10
      move_train
    when 11
      list_trains_and_stations
    when 0
      exit
    end
  end

  def create_station
    begin
      puts 'Введите название станции'
      name = gets.chomp.to_s
      puts "Станция: #{name} создана" if Station.new(name).valid?
    rescue RuntimeError
      puts 'Введите корректное название станции!!!'
      retry
    end
    stations << Station.new(name)
    main_menu
  end

  def create_train
    puts 'Нажмите 1 чтобы, Создать пассажирский поезд'
    puts 'Нажмите 2 чтобы, Создать грузовой поезд'
    input = gets.chomp.to_i
    case input
    when 1
      new_passenger_train
    when 2
      new_cargo_train
    end
  end

  def new_passenger_train
    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      puts "Поезд с номером: #{number} создан" if PassengerTrain.new(number).valid?
    rescue RuntimeError
      puts 'Введите коректный номер поезда!!!'
      retry
    end
    trains << PassengerTrain.new(number)
    main_menu
  end

  def new_cargo_train
    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      puts "Поезд с номером: #{number} создан" if CargoTrain.new(number).valid?
    rescue RuntimeError
      puts 'Введите коректный номер поезда!!!'
      retry
    end
    trains << CargoTrain.new(number)
    main_menu
  end

  def create_wagon
    puts 'Нажмите 1 чтобы, создать пассажирский вагон'
    puts 'Нажмите 2 чтобы, создать грузовой вагон'
    puts 'Нажмите 3 чтобы, занять место или объём в вагоне'
    input = gets.chomp.to_i
    case input
    when 1
      puts 'Введите количество мест'
      number = gets.chomp.to_i
      wagon = PassengerWagon.new(number, :passenger)
      passenger_wagons << wagon
      passenger_wagons.each do |wagon|
        puts "Номер вагона:#{wagon.number}
         Свободных мест:#{wagon.free_spaces?}
         Занятых мест:#{wagon.busy_spaces?}
         Тип:#{wagon.type}"
      end
      puts passenger_wagons
      main_menu
    when 2
      puts 'Введите объём'
      volume = gets.chomp.to_i
      wagon = CargoWagon.new(volume, :cargo)
      @cargo_wagons << wagon
      cargo_wagons.each do |wagon|
        puts "Номер вагона:#{wagon.number}
         Свободный объём:#{wagon.free_volume?}
         Занятый объём:#{wagon.busy_volume?}
         Тип:#{wagon.type}"
      end
      main_menu
    when 3
      puts 'Выберите тип вагонов: 1 - пассажирский 2 - грузовой'
      input = gets.chomp.to_i
      if input == 1
        passenger_wagons.each.with_index do |wagon, index|
          puts "Индекс: #{index}
          Номер вагона:#{wagon.number}
          Свободных мест:#{wagon.free_spaces?}
          Занятых мест:#{wagon.busy_spaces?}
          Тип:#{wagon.type}"
        end
        puts 'Введите Индекс вагона в котором требуется занять место'
        number = gets.chomp.to_i
        passenger_wagons[number].takes_space
        passenger_wagons.each do |wagon|
          puts "Номер вагона:#{wagon.number}
          Свободных мест:#{wagon.free_spaces?}
          Занятых мест:#{wagon.busy_spaces?}
          Тип:#{wagon.type}"
        end
        main_menu
      elsif input == 2
        cargo_wagons.each.with_index do |wagon, index|
          puts "Индекс: #{index}
          Номер вагона:#{wagon.number}
          Свободный объём:#{wagon.free_volume?}
          Занятый объём:#{wagon.busy_volume?}
          Тип:#{wagon.type}"
        end
        puts 'Введите Индекс вагона в котором требуется занять объём'
        number = gets.chomp.to_i
        current_wagon = cargo_wagons[number]
        puts 'Введите объём'
        volume = gets.chomp.to_i
        current_wagon.takes_volume(volume)
        cargo_wagons.each do |wagon|
          puts "Номер вагона:#{wagon.number}
          Свободный объём:#{wagon.free_volume?}
          Занятый объём:#{wagon.busy_volume?}
          Тип:#{wagon.type}"
        end
        main_menu
      end
    end
  end

  def create_route
    puts 'Для создания маршрута требуется ввести 2 станции из общего списка станций'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts 'Введите номер начальной станции'
    number_first = gets.chomp.to_i
    first = @stations[number_first]
    puts 'Введите номер конечной станции'
    number_last = gets.chomp.to_i
    last = @stations[number_last]
    routes << Route.new(first, last)
    main_menu
  end

  def add_stations_on_route
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map(&:name)}" }
    puts 'Выберите маршрут в который требуется добавить станцию - введите номер'
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts 'Введите номер промежуточной станции'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.add_station(stations[number_station])
    main_menu
  end

  def delete_stations_on_route
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map(&:name)}" }
    puts 'Выберите маршрут в котором требуется удалить станцию - введите номер'
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts 'Введите номер промежуточной станции'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.delete_station(stations[number_station])
    main_menu
  end

  def set_route_to_train
    puts 'Выберите маршрут для поезда'
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map(&:name)}" }
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts 'Выберите поезд'
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    number_train = gets.chomp.to_i
    current_train = trains[number_train]
    current_train.add_route(current_route)
    main_menu
  end

  def add_wagon
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Выберите поезд для добавления к нему вагона'
    number_train = gets.chomp.to_i
    if trains[number_train].type == :cargo
      cargo_wagons.each.with_index do |wagon, index|
        puts "Индекс: #{index}
        Номер вагона:#{wagon.number}
        Свободный объём:#{wagon.free_volume?}
        Занятый объём:#{wagon.busy_volume?}
        Тип:#{wagon.type}"
      end
      puts 'Введите Индекс вагона для добавления'
      number_wagon = gets.chomp.to_i
      trains[number_train].add_wagon(cargo_wagons[number_wagon])
    elsif trains[number_train].type == :passenger
      passenger_wagons.each.with_index do |wagon, index|
        puts "Индекс: #{index}
        Номер вагона:#{wagon.number}
        Свободных мест:#{wagon.free_spaces?}
        Занятых мест:#{wagon.busy_spaces?}
        Тип:#{wagon.type}"
      end
      puts 'Введите Индекс вагона для добавления'
      number_wagon = gets.chomp.to_i
      trains[number_train].add_wagon(passenger_wagons[number_wagon])
    end
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def delete_wagon
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Выберите поезд для отцепления от него вагона'
    number_train = gets.chomp.to_i
    trains[number_train].delete_wagon unless trains[number_train].wagons.empty?
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def move_train
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Выберите поезд для перемещения по маршруту'
    number_train = gets.chomp.to_i
    puts 'Для перемещения вперед нажмите 1 для перемещения назад 2'
    input = gets.chomp.to_i
    if input == 1 
      trains[number_train].move_forward
    elsif input == 2 
      trains[number_train].move_back
    end
    main_menu
  end

  def list_trains_and_stations
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Выберите поезд'
    number_train = gets.chomp.to_i
    if trains[number_train].type == :cargo
      trains[number_train].each_wagon do |wagon|
        puts "Номер вагона:#{wagon.number}
        Свободный объём:#{wagon.free_volume?}
        Занятый объём:#{wagon.busy_volume?}
        Тип:#{wagon.type}"
      end
    elsif trains[number_train].type == :passenger
      trains[number_train].each_wagon do |wagon|
        puts "Номер вагона:#{wagon.number}
        Свободных мест:#{wagon.free_spaces?}
        Занятых мест:#{wagon.busy_spaces?}
        Тип:#{wagon.type}"
      end
    end
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts 'Введите номер станции для просмотра поездов на ней'
    number_station = gets.chomp.to_i
    stations[number_station].each_train do |train|
      puts "номер поезда:#{train.number}
      тип:#{train.type}
      количество вагонов: #{train.count_wagons}"
    end
    main_menu
  end
end
main = Main.new
main.main_menu