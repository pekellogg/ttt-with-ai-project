require "pry"
class Board
    @@all = []
    
    def self.all
        @@all
    end
    
    attr_accessor :cells

    def initialize
        self.reset!
    end

    def reset!
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    # use at end of game to store completed board (if possible, per FI test suite)
    def save
        self.class.all << self
    end

    def display
        puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
        puts "-----------"
        puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
        puts "-----------"
        puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def clean(input)
        (input.class == Integer) ? input : (self.input_to_index(input))
    end

    def position(input)
        self.cells[self.clean(input)]
    end

    def full?
        self.cells.all?{|i| i == "X" || i == "O"}
    end

    def turn_count
        occupied = 0
        self.cells.each{|i|occupied += 1 if i != " "}
        occupied
    end

    def taken?(input)
        self.position(input) != " "
    end

    # valid == not occupied and user input between 0...8
    def valid_move?(input)
        cleaned = self.clean(input)
        !self.taken?(cleaned) && cleaned.between?(0, 8)
    end

    def update(input, current_player = "X")
        i = self.clean(input)
        if self.valid_move?(i)
            self.cells[i] = current_player.token
        else
            self.invalid_move(current_player)
        end     
    end

    def invalid_move(current_player)
        puts "Please enter a valid selection."
        valid = gets.chomp
        self.update(valid, current_player)
    end
end
