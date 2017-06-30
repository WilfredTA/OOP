 class Banner
  def initialize(message)
      @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_accessor :string
    
  def horizontal_rule
      self.string = ''
    @message.size.times do 
        string << '-'
    end
    '+-' + string + '-+'
  end

  def empty_line
    '| ' + spaces + ' |'
  end
  
  def spaces
    spaces = ''
    string.size.times do 
      spaces << ' '
    end
    spaces
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new("To infinity and beyond!!")
puts banner