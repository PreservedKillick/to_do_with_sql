require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def list_menu

  puts "LISTS"
  puts "=======\n"
  puts "Please choose which list you want to add to: \n"
  List.list_out
  name_input = gets.chomp
  @current_list = List.list_out[name_input.to_i - 1]
  main_menu
end

def create_list
  system "clear"
  puts "Please enter the name of your list"
  input_name = gets.chomp
  @new_list = List.create(input_name)
  @current_list = @new_list
  main_menu
end

def main_menu

  puts "\nADD MENU"
  puts "========="

  puts "\n"
  puts @current_list
  puts @current_list.class
  puts "Press 'a' to add a task to #{@current_list['name']}"
  puts "Press 'l' to list all of your tasks in #{@current_list['name']}"
  puts "Press 'n' to create a new list"
  puts "Press 'L' to show your lists"
  puts "Press 'x' to exit."

  main_choice = gets.chomp
  case main_choice
  when 'a'
    add_task
  when 'l'
    list_tasks
  when 'n'
    create_list
  when 'L'
    list_menu
  when 'x'
    puts "Thanks for nothing"
    exit
  else
    main_menu
  end
end

def add_task
  puts "Enter the description for the task:\n\n"
  task_input = gets.chomp
  new_task = Task.new(task_input, "#{@current_list['id'].to_i}")
  new_task.save
  puts "Task added!\n"
  main_menu
end

def list_tasks
  puts "\n"
  results = DB.exec("SELECT * FROM tasks WHERE list_id = #{@current_list['id'].to_i};")
    results.each_with_index do |result, index|
      puts "#{index + 1}) #{result['description']}"
  end
  puts "\n"
  main_menu
end

if List.all == []
  create_list
else
  list_menu
end
