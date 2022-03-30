# todo.rb
require "active_record"

class Todo < ActiveRecord::Base
  def dute_today?
    due_date == Date.today
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    Todo.update(id, completed: true)
  end

  def to_displayable_string
    display_status = completed ? "[x]" : "[ ]"
    display_date = dute_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue"
    puts Todo.where("due_date < ?", Date.today).map { |todo| todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Today"
    puts Todo.where("due_date = ?", Date.today).map { |todo| todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Later"
    puts Todo.where("due_date > ?", Date.today).map { |todo| todo.to_displayable_string }.join("\n")
  end
end
