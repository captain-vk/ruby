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

  INPUT_CONTROL_WAGONS = { '1': 'create_pass_wagon', '2': 'create_cargo_wagon', '3': 'control_wagons' }.freeze
  INPUT_MAIN_MENU = {
    '1': 'create_station', '2': 'create_train', '3': 'create_wagon', '4': 'create_route',
    '5': 'add_stations_on_route', '6': 'delete_stations_on_route', '7': 'set_route_to_train',
    '8': 'add_wagon', '9': 'delete_wagon', '10': 'move_train', '11': 'list_trains_wagons',
    '0': 'exit'
  }.freeze

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
    input = gets.chomp.to_sym
    send INPUT_MAIN_MENU[input]
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
    input = gets.chomp.to_sym
    send INPUT_CONTROL_WAGONS[input]
  end

  def control_wagons
    puts 'Выберите тип вагонов: 1 - пассажирский 2 - грузовой'
    input = gets.chomp.to_i
    case input
    when 1
      control_pass_wagons
    when 2
      control_cargo_wagons
    end
  end

  def control_pass_wagons
    number = show_pass_wagons
    passenger_wagons[number].takes_space
    main_menu
  end

  def control_cargo_wagons
    number = show_cargo_wagons
    puts 'Введите объём'
    volume = gets.chomp.to_i
    cargo_wagons[number].takes_volume(volume)
    main_menu
  end

  def create_pass_wagon
    puts 'Введите количество мест'
    number = gets.chomp.to_i
    wagon_new = PassengerWagon.new(number, :passenger)
    passenger_wagons << wagon_new
    show_curr_pass_wagon(wagon_new)
    main_menu
  end

  def show_cargo_wagons
    cargo_wagons.each.with_index do |wagon, index|
      puts "Индекс: #{index}
      Номер вагона:#{wagon.number}
      Свободный объём:#{wagon.free_volume?}
      Занятый объём:#{wagon.busy_volume?}
      Тип:#{wagon.type}"
    end
    puts 'Введите Индекс вагона'
    number_wagon = gets.chomp.to_i
    number_wagon
  end

  def show_pass_wagons
    passenger_wagons.each.with_index do |wagon, index|
      puts "Индекс: #{index}
      Номер вагона:#{wagon.number}
      Свободных мест:#{wagon.free_spaces?}
      Занятых мест:#{wagon.busy_spaces?}
      Тип:#{wagon.type}"
    end
    puts 'Введите Индекс вагона'
    number_wagon = gets.chomp.to_i
    number_wagon
  end

  def create_cargo_wagon
    puts 'Введите количество объёма'
    number = gets.chomp.to_i
    wagon_new = CargoWagon.new(number, :cargo)
    cargo_wagons << wagon_new
    show_curr_carr_wagon(wagon_new)
    main_menu
  end

  def show_curr_pass_wagon(wagon)
    puts "Вагон номер: #{wagon.number} Всего мест: #{wagon.total_spaces} Тип: #{wagon.type}"
  end

  def show_curr_carr_wagon(wagon)
    puts "Вагон номер: #{wagon.number} Весь объём: #{wagon.total_volume} Тип: #{wagon.type}"
  end

  def create_route
    stations = list_stations
    routes << Route.new(@stations[stations[0]], @stations[stations[1]])
    main_menu
  end

  def list_stations
    puts 'Для создания маршрута требуется ввести 2 станции из общего списка станций'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts 'Введите номер начальной станции'
    number_first = gets.chomp.to_i
    puts 'Введите номер конечной станции'
    number_last = gets.chomp.to_i
    [number_first, number_last]
  end

  def add_stations_on_route
    current_route = routes[change_route]
    station_number = show_station
    current_route.add_station(stations[station_number])
    main_menu
  end

  def show_station
    puts 'Введите номер промежуточной станции'
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    station_number = gets.chomp.to_i
    station_number
  end

  def change_route
    routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map(&:name)}" }
    puts 'Выберите маршрут - введите номер'
    number_route = gets.chomp.to_i
    number_route
  end

  def delete_stations_on_route
    current_route = routes[change_route]
    station_number = show_station
    current_route.delete_station(stations[station_number])
    main_menu
  end

  def set_route_to_train
    current_route = routes[change_route]
    number_train = show_trains
    trains[number_train].add_route(current_route)
    main_menu
  end

  def add_wagon
    number_train = show_trains
    if trains[number_train].type == :cargo
      add_cargo_wagon(number_train)
    elsif trains[number_train].type == :passenger
      add_pass_wagon(number_train)
    end
  end

  def add_pass_wagon(number_train)
    number_wagon = show_pass_wagons
    trains[number_train].add_wagon(passenger_wagons[number_wagon])
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def add_cargo_wagon(number_train)
    number_wagon = show_cargo_wagons
    trains[number_train].add_wagon(cargo_wagons[number_wagon])
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def delete_wagon
    number_train = show_trains
    trains[number_train].delete_wagon unless trains[number_train].wagons.empty?
    puts "Количество вагонов у данного поезда - #{trains[number_train].count_wagons}"
    main_menu
  end

  def move_train
    number_train = show_trains
    puts 'Для перемещения вперед нажмите 1 для перемещения назад 2'
    input = gets.chomp.to_i
    if input == 1
      trains[number_train].move_forward
    elsif input == 2
      trains[number_train].move_back
    end
    main_menu
  end

  def show_trains
    trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Выберите поезд'
    number_train = gets.chomp.to_i
    number_train
  end

  def list_trains_wagons
    number_train = show_trains
    if trains[number_train].type == :cargo
      list_trains_wagons_cargo(number_train)
    elsif trains[number_train].type == :passenger
      list_trains_wagons_pass(number_train)
    end
    list_stations_trains
  end

  def list_trains_wagons_cargo(number_train)
    trains[number_train].each_wagon do |wagon|
      puts "Номер вагона:#{wagon.number}
      Свободный объём:#{wagon.free_volume?}
      Занятый объём:#{wagon.busy_volume?}
      Тип:#{wagon.type}"
    end
  end

  def list_trains_wagons_pass(number_train)
    trains[number_train].each_wagon do |wagon|
      puts "Номер вагона:#{wagon.number}
      Свободных мест:#{wagon.free_spaces?}
      Занятых мест:#{wagon.busy_spaces?}
      Тип:#{wagon.type}"
    end
  end

  def list_stations_trains
    number_station = show_stations
    stations[number_station].each_train do |train|
      puts "номер поезда:#{train.number}
      тип:#{train.type}
      количество вагонов: #{train.count_wagons}"
    end
    main_menu
  end

  def show_stations
    stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts 'Введите номер станции для просмотра поездов на ней'
    number_station = gets.chomp.to_i
    number_station
  end
end
main = Main.new
main.main_menu
