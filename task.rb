require "date"
class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts "Что надо сделать?"
    @text = STDIN.gets.chomp

    puts "К какому числу? Укажите дату в формате ДД.ММ.ГГГГ, например 29.04.2022"
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    dead_line = "Крайний срок: #{@due_date}"

    return [dead_line, @text, time_string]
  end

  def to_db_hash
    return super.merge(
                    {
                      "text" => @text,
                      "due_date" => @due_date.to_s
                    }
  )
  end

  def load_data(data_hash)
    super(data_hash)

    @due_date = Date.parse(data_hash["due_date"])
  end
end