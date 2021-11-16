class Game
    attr_accessor :board, :player_1, :player_2

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board, @player_1, @player_2 = board, player_1, player_2
    end

    WIN_COMBINATIONS = [
        [0, 1, 2], # top row win
        [3, 4, 5], # middle row win
        [6, 7, 8], # bottom row win
        [0, 3, 6], # left vertical win
        [1, 4, 7], # middle vertical win
        [2, 5, 8], # right vertical win
        [6, 4, 2], # diagonal win 1
        [0, 4, 8] # diagonal win 2
    ]

    def welcome
        puts "Hello! Please choose who to play Tic Tac Toe with."
        puts "0: I want to be a spectator and watch the computer play against itself."
        puts "1: I want to test my Tic Tac Toe skills against the computer."
        puts "2: I want to play a human friend."
        # player_mode(gets.chomp)
    end

    # def player_mode(input)
    #     case input
    #     when 0
    #         Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
    #     when 1
    #         puts "Would you like to go first and be player X? Y/N"
    #         case gets.chomp
    #         when "Y" || "y"
    #             Game.new(Players::Human.new("X"), Players::Computer.new("O"))
    #         end
    #     when 2

    #     end
    # end

    def start

        self.play
    end

    def play
        until self.over?
          self.turn
        end
        if self.won?
          puts "Congratulations #{self.winner}!"
        elsif self.draw?
          puts "Cat's Game!"
        end
    end

    def turn
        selection = self.current_player.move(self.board)
        if self.board.valid_move?(selection)
            self.board.update(selection, self.current_player) # learned to be consistent when passing obj vs obj.attr; obj might be preferred
            self.board.display
        else
            self.turn
        end
    end

    def current_player
        i = self.board.turn_count
        i.even? ? self.player_1 : self.player_2
    end

    def full?
        self.board.cells.all?{|i| i == "X" || i == "O"}
    end

    def draw?
        (!self.won? && self.full?) ? true : false
    end

    def over?
        (self.won? || self.draw?) ? true : false
    end

    def won?
        WIN_COMBINATIONS.detect do |combination|
            self.board.cells[combination[0]] == self.board.cells[combination[1]] &&
            self.board.cells[combination[1]] == self.board.cells[combination[2]] &&
            self.board.taken?(combination[2] + 1) 
        end
    end

    def winner
        if self.won? != nil
            @winner = self.board.cells[self.won?.first]
        end
    end
end