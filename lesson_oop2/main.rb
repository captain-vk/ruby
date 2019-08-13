require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'
require_relative 'CargoWagon'
require_relative 'PassengerWagon'

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
end

def create_train
  puts "Нажмите 1 чтобы, Создать пассажирский поезд"
  puts "Нажмите 2 чтобы, Создать грузовой поезд"
  input = gets.chomp.to_i
  case input
    when 1
      puts "Введите номер поезда"
      number = gets.chomp
      train = PassengerTrain.new(number)
    when 2
      puts "Введите номер поезда"
      number = gets.chomp
      train = CargoTrain.new(number)
      end
  trains << train
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
    end

  def add_wagon
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts "Выберите поезд для добавления к нему вагона"
    number_train = gets.chomp.to_i
      if trains[number_train].type == 'cargo'
          trains[number_train].add_wagon(CargoWagon.new('cargo'))
        elsif trains[number_train].type == 'passenger'
            trains[number_train].add_wagon(PassengerWagon.new('passenger'))
      end

    end
    #puts "Если требуется добавить промежуточную станцию"


  #  number = gets.chomp
  #  trains.each do |train|
  #    if trains.include(number)
  #      current_train = train
  #      puts "Поезд найден!"
  #      puts "Введите начальную станцию"
  #      first = gets.chomp
  #      puts "Введите конечную станцию"
  #      last = gets.chomp
  #    else
  #      exit
  #    end
  #  route = Route.new(first, last)
  #  current_train.add_route(route)

  end
