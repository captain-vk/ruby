require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'company'


class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def main_menu
    puts "Нажмите 1 чтобы, Создать станцию"
    puts "Нажмите 2 чтобы, Создать поезд"
    puts "Нажмите 3 для создания маршрута"
    puts "Нажмите 4 для добавления станции в маршруте"
    puts "Нажмите 5 для удаления станции в маршруте"
    puts "Нажмите 6 чтобы, Назначить маршрут поезду"
    puts "Нажмите 7 чтобы, Добавлять вагоны к поезду"
    puts "Нажмите 8 чтобы, Отцеплять вагоны от поезда"
    puts "Нажмите 9 чтобы, Перемещать поезд по маршруту вперед и назад"
    puts "Нажмите 10 чтобы, Просматривать список станций и список поездов на станции"
    puts "Нажмите 0 для выхода"
    input = gets.chomp.to_i

    case input
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      add_stations_on_route
    when 5
      delete_stations_on_route
    when 6
      get_route_to_train
    when 7
      add_wagon
    when 8
      delete_wagon
    when 9
      move_train
    when 10
      list_trains_and_stations
    when 0
      exit
    end
  end

  def create_station
    puts "Введите название станции"
    name = gets.chomp.to_s
    station = Station.new(name)
    stations << station
   main_menu
  end

  def create_train
    puts "Нажмите 1 чтобы, Создать пассажирский поезд"
    puts "Нажмите 2 чтобы, Создать грузовой поезд"
    input = gets.chomp.to_i
    case input
    when 1
      begin
      puts "Введите номер поезда"
      number = gets.chomp 
      if PassengerTrain.new(number).valid? 
        puts "Поезд с номером: #{number} создан"
      end
      rescue RuntimeError
        puts "Введите коректный номер поезда!!!"
      retry
      end
      train = PassengerTrain.new(number)
    when 2
      begin
      puts "Введите номер поезда"
      number = gets.chomp 
      if CargoTrain.new(number).valid? 
        puts "Поезд с номером: #{number} создан"
      end
      rescue RuntimeError
        puts "Введите коректный номер поезда!!!"
      retry
      end
      train = CargoTrain.new(number)
    end
    trains << train
    main_menu
  end

  def create_route
    puts "Для создания маршрута требуется ввести 2 станции из общего списка станций"
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts "Введите номер начальной станции"
    number_first = gets.chomp.to_i
    first = @stations[number_first]
    puts "Введите номер конечной станции"
    number_last = gets.chomp.to_i
    last = @stations[number_last]
    routes << Route.new(first, last)
    main_menu
  end

  def add_stations_on_route
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    puts "Выберите маршрут в который требуется добавить станцию - введите номер"
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts "Введите номер промежуточной станции"
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.add_station(stations[number_station])
    main_menu
  end

  def delete_stations_on_route
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    puts "Выберите маршрут в котором требуется удалить станцию - введите номер"
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts "Введите номер промежуточной станции"
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.delete_station(stations[number_station])
    main_menu
  end

  def get_route_to_train
    puts "Выберите маршрут для поезда"
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    number_route = gets.chomp.to_i
    current_route = routes[number_route]
    puts "Выберите поезд"
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    number_train = gets.chomp.to_i
    current_train = trains[number_train]
    current_train.add_route(current_route)
    main_menu
  end

  def add_wagon
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts "Выберите поезд для добавления к нему вагона"
    number_train = gets.chomp.to_i
    if trains[number_train].type == :cargo
      trains[number_train].add_wagon(CargoWagon.new(:cargo))
    elsif trains[number_train].type == :passenger
      trains[number_train].add_wagon(PassengerWagon.new(:passenger))
    end
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def delete_wagon
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts "Выберите поезд для отцепления от него вагона"
    number_train = gets.chomp.to_i
    trains[number_train].delete_wagon if trains[number_train].wagons.length != 0
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def move_train
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts "Выберите поезд для перемещения по маршруту"
    number_train = gets.chomp.to_i
    puts "Для перемещения вперед нажмите 1 для перемещения назад 2"
    input = gets.chomp.to_i
    case input
    when 1
      trains[number_train].move_forward
    when 2
      trains[number_train].move_back
    end
    main_menu
  end

  def list_trains_and_stations
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts "Введите номер станции для просмотра поездов на ней"
    number_station = gets.chomp.to_i
    number_train = stations[number_station].trains.map { |train| train.number}
    type_train = stations[number_station].trains.map { |train| train.type}
    puts "номер поезда:#{number_train} тип:#{type_train}"
    main_menu
  end
end

main = Main.new
main.main_menu
