require 'pry'
class Game
    class InvalidInputSelectionError < StandardError; end

    # add in final project version as test suite allows
    # @@all = []

    # def self.all
    #     @@all
    # end

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
        puts "Please enter 1-9:"
        input = self.current_player.input
        i = self.board.clean(input)
        if self.valid_move?(i)
            self.move(i, self.current_player) # pass obj or obj.attr? #=> self.current_player vs. self.current_player.token
            self.board.display
        else
            begin
                raise InvalidInputSelectionError.new("invalid")
            rescue InvalidInputSelectionError => e
                puts e.message
                self.turn
            end
        end
    end

    def valid_move?(index)
        index.between?(0,8) && !self.board.taken?(index)
    end

    def move(index, player_token = "X")
        self.board.cells[index] = self.current_player.token
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
        WIN_COMBINATIONS.each do |combination|
            p1 = self.board.cells[combination[0]]
            p2 = self.board.cells[combination[1]]
            p3 = self.board.cells[combination[2]]
            matching = ((p1 == p2) && (p2 == p3))
            if self.board.taken?(combination.first) && matching
                return combination
            end
        end
        false
    end

    def winner
        self.won? ? self.board.cells[self.won?.first] : nil
    end
end

# game = Game.new
# game.start