module Players
    class Human < Player
        # Players::Human <- syntax for calls to Human class
        def move(input)
            puts "Where would you like to move?"
            input = gets.chomp
        end
    end
end


