require 'pg'

class List

  attr_reader :name, :id

  def List.get_list(list_id)
    db_list = DB.exec("SELECT * FROM lists WHERE id = '#{@list_id.to_i}';")
    db_list.first
  end

  def initialize(name, id = nil)
    @tasks = []
    @name = name
    @id = id
  end

  def self.create(name, id = nil)
    new_list = List.new(name)
    new_list.save
    new_list
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.list_out
   results = DB.exec("SELECT * FROM lists;")
      results.each_with_index do |result, index|
        puts "#{index + 1}) #{result['name']}"
    end
  end


  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      lists << List.new(name)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

end
