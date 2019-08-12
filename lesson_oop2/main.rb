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
  puts "Нажмите 4 для управлениями станциями в маршруте"
  puts "Нажмите 5 чтобы, Назначить маршрут поезду"
  puts "Нажмите 6 чтобы, Добавлять вагоны к поезду"
  puts "Нажмите 7 чтобы, Отцеплять вагоны от поезда"
  puts "Нажмите 8 чтобы, Перемещать поезд по маршруту вперед и назад"
  puts "Нажмите 9 чтобы, Просматривать список станций и список поездов на станции"
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
    control_stations_on_route
  when 5
    get_route_to_train
  when 6
    add_wagon
  when 7
    delete_wagon
  when 8
    move_train
  when 9
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
      train = Train.new(number,'passenger')
    when 2
      puts "Введите номер поезда"
      number = gets.chomp
      train = Train.new(number,'cargo')
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

  def control_stations_on_route
    puts "Выберите маршрут для редактирования - введите номер"
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.name}" }


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
