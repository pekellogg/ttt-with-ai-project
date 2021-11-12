module Players
    class Human < Player
        # Players::Human <- syntax for calls to Human class
        def move(board)
            puts "Please enter 1-9:"
            gets.chomp
        end
    end
end


