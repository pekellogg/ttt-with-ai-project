require "pry"
class Board
    # add as test suite allows
    # @@all = []
    
    # def self.all
    #     @@all
    # end
    
    attr_accessor :cells

    def initialize
        self.reset!
    end

    def reset!
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
    # add as test suite allows
    # def save
    #     self.class.all << self
    # end

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

    def position(input)
        self.cells[input_to_index(input)]
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

    def valid_move?(input)
        input.to_i.between?(1,9) && !self.taken?(input)
    end

    def update(input, current_player)
        self.cells[self.input_to_index(input)] = current_player.token
    end
end
