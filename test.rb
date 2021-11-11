require 'pry'

def callback_msg
    puts "Call #understand_exception_messages with two int args."
end

def understand_exception_messages(number_1, number_2)
    if number_1 && number_2
        puts "#{number_1 + number_2}"
    else
        begin
            # raises an ArgumentError with the message "you messed up!"
            raise ArgumentError.new("Missing arguments.")
        rescue ArgumentError => e  
            puts e.message
            callback_msg
        end
    end
end

understand_exception_messages(1, 1)
understand_exception_messages(1)