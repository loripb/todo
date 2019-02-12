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
      Q) Quit "
  end

 def show # method to output the menu
   menu
 end
end

module Promptable
  # method for promting user input
  def prompt(message = 'What would you like to do?', symbol = ':>')
    print message
    print symbol
    gets.chomp
  end
end

# Classes
class List

  attr_reader :all_tasks
  def initialize
    @all_tasks = []
  end

  def add(task) # adds a task to all_tasks array
    all_tasks << task
  end

  def remove(num)
    num = num.to_i
    num -= 1

    all_tasks.delete_at(num)
  end

  def update(task_num, task)
    all_tasks[task_num - 1] = task
  end

  def show # nubers each task in output
    i = 1
    all_tasks.each do |task|
      puts "#{i.to_s}) #{task} "

      i += 1
    end
  end

  def write_to_file(filename) # creats a file of the all_tasks array in directory of the program.
    IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
  end

  def read_from_file(filename) # outputs a files contents
        IO.readlines(filename).each do |line|
          puts line.chomp
        end
      end

end

class Task

  attr_accessor :description
  def initialize(description)
    @description = description
  end

  def to_s # turns the task decription into a string
    description
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

          my_list.show

        when '5'

          my_list.write_to_file(prompt('Choose a name for your file.'))

          puts ''
          puts 'File created successfully!'
          puts ''

        when '6'

          begin
            my_list.read_from_file(prompt('What is the filename to
            read from?'))

          rescue Errno::ENOENT # erro checks if the file entered exists
            puts 'File name not found, please verify your file name
            and path and try again.'


          end

        else

        puts ''
        puts 'Try again, I did not understand.'
        puts ''
      end

    end

   puts ''
   puts 'Outro - Thanks for using the menu system!'

  end
