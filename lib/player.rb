class Player
    # add as test suite allows
    # @@all = []

    # def self.all
    #     @@all
    # end

    attr_reader :token
    attr_accessor :input

    def initialize(token)
        @token = token
        # self.save if self.unique?
    end

    # def save
    #     self.class.all << self
    # end

    # def unique?
    #     !self.class.all.include?(self)
    # end

    def input
        gets.strip
    end
end