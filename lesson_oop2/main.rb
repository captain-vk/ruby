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
  puts "Нажмите 3 для создания маршрута и управления станциями в нём"
  puts "Нажмите 4 чтобы, Назначить маршрут поезду"
  puts "Нажмите 5 чтобы, Добавлять вагоны к поезду"
  puts "Нажмите 6 чтобы, Отцеплять вагоны от поезда"
  puts "Нажмите 7 чтобы, Перемещать поезд по маршруту вперед и назад"
  puts "Нажмите 8 чтобы, Просматривать список станций и список поездов на станции"
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
    get_route_to_train
  when 5
    add_wagon
  when 6
    delete_wagon
  when 7
    move_train
  when 8
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
    stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
    puts "Введите номер начальной станции"
    number_first = gets.chomp.to_i
    first_name = ''
    last_name = ''
    stations.each.with_index(1) { |station_first, index| first_name = station_first.name if index == number_first }
    first = Station.new(first_name)
    puts "Введите номер конечной станции"
    number_last = gets.chomp.to_i
    stations.each.with_index(1) { |station_last, index| last_name =  station_last.name if index == number_last }
    last = Station.new(last_name)
    routes << Route.new(first, last)
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



end
