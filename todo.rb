# Module
module Menu
  # menu for user interation
  def menu
    " Welcome to the TodoList Program!
      This menu will help you use the Task List System
      1) Add
      2) Remove
      3) Update
      4) Show
      5) Write to a file
      6) View a file
      7) Toggle
      Q) Quit "
  end

 def show # method to output the menu
   menu
 end
end

module Promptable
  # method for promting for user input
  def prompt(message = 'What would you like to do?', symbol = ':>')
    print message
    print symbol
    gets.chomp
  end
end

# Classes
class List
  #initializing the instance variable all_tasks
  attr_reader :all_tasks
  def initialize
    @all_tasks = []
  end

  def add(task) # adds a task to all_tasks array
    all_tasks << task
  end

  def remove(num) # removes a task from the all_tasks array
    num = num.to_i
    num -= 1

    all_tasks.delete_at(num)
  end

  def update(task_num, task) # updates an existing task
    all_tasks[task_num - 1] = task
  end

  def show # nubers each task in output
    i = 0
    all_tasks.each do |task|
      puts "#{i.next}) : #{task}"

      i += 1
    end
  end

  def toggle(task_num) # toggles the comepletion status of a task
    all_tasks[task_num.to_i - 1].toggle_status
  end

  def write_to_file(filename) # writes the task list to a new or existing file
     machinified = all_tasks.map(&:to_machine).join("\n")
     IO.write(filename, machinified)
  end

  def read_from_file(filename) # grabs the task list from an existing file
    IO.readlines(filename).each do |line|
      status, *description = line.split(':')
      status = status.downcase.include?('x')
      add(Task.new(description.join(':').strip, status))
    end
  end

end

class Task
  # initializes the instance variables description and completed_status
  attr_reader :description
  attr_accessor :completed_status
  def initialize(description, completed_status = false)
    @description = description
    @completed_status = completed_status
  end

  def to_s # turns the task decription into a string and gives it a comepletion status
    "#{represent_status} : #{description}"
  end

  def completed? # checks is a tasks status is completed
    completed_status
  end

  def to_machine # used for writing to file method, it formats to description and task status
                 # so it is ready to be writen to a file
    "#{represent_status} : #{description}"
  end

  def toggle_status # toggles completion status
    @completed_status = !completed?
  end

  private
  def represent_status # defines to completed task switch
    completed? ? '[X]' : '[ ]'
  end


end

# Program runner
if __FILE__ == $PROGRAM_NAME

  include Menu
  include Promptable
  my_list = List.new

  puts 'Please choose from the following list.'

  until ['q'].include?(user_input = prompt(show).downcase) # q outputs outro an quits program

    case user_input

        when '1'
          my_list.add(Task.new(prompt('What would like to accomplish?')))

          puts ''
          puts 'Task successfully added!'
          puts ''

        when '2'
          my_list.remove(prompt('Choose the index number of the task you wish to remove.'))

          puts ''
          puts 'Task successfully deleted!'
          puts ''

        when '3'
          my_list.update(prompt('Which task would you like to update?').to_i , Task.new(prompt('Enter a new discription.')))

          puts ''
          puts 'Task successfully updated!'
          puts ''

        when '4'
          puts my_list.show

        when '5'
          my_list.write_to_file(prompt('Choose a name for your file.'))

          puts ''
          puts 'File created successfully!'
          puts ''

        when '6'
          begin
            my_list.read_from_file(prompt('What is the filename to read from?'))
          rescue Errno::ENOENT
            puts 'File name not found, please verify your filename and path.'
          end

        when '7'
          puts my_list.show
          my_list.toggle(prompt('Choose a task.').to_i)

        else

        puts ''
        puts 'Try again, I did not understand.'
        puts ''
      end
      prompt('Press enter to continue.', '')
    end

   puts ''
   puts 'Outro - Thanks for using the menu system!'

  end
