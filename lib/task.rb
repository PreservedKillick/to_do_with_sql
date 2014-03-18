require 'pg'

class Task

  attr_reader :description, :list_id

  def initialize(description, list_id)
    @description = description
    @list_id = list_id
  end

  def ==(another_task)
    self.description == another_task.description && self.list_id == another_task.list_id
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      description = result['description']
      list_id = result['list_id'].to_i
      tasks << Task.new(description, list_id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', '#{@list_id}');")
  end

end
