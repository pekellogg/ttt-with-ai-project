module Players
    class Computer < Player
        # Players::Computer <- syntax for calls to Computer class
        CORNERS = [1, 3, 7, 9]
        SIDES = [2, 4, 6, 8]
        #corners_occupied?
        #find_corners
        #find_sides
        #best_move
        #block_opponent
        def move(board)
            #initialize #move as nil to start
            @move = nil
            
            #1st
            @move = "5" if !board.taken?(5)
            
            #2nd
            @move = "1" if board.taken?(5)
            
            #3rd
            @move = CORNERS.find{|i| !board.taken?(i)}.to_s if board.taken?(5) && board[5 + 1] == self.token
            
            #4th
            #if corners occupied, next best move is sides
            if (board.position(1) == board.position(9) || board.position(3) == board.position(7))
              if (board.position(3) == board.position(7) || board.position(1) == board.position(9))
                @move = SIDES.find{|i| !board.taken?(i)}.to_s
              end
              
              #check remaining positions avail against WIN_COMBINATIONS
            else
              Game::WIN_COMBINATIONS.find do |cmb|
                #1st check: see if your next move can be a winning combo
                if cmb.select{|i| board.position(i+1) == self.token}.size == 2 && cmb.any?{|i| board.position(i+1) == " "}
                  @move = cmb.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
      
                #2nd check: block opponent if you can't make a winning combo
                elsif cmb.select{|i| board.position(i+1) != " " && board.position(i+1) != token}.size == 2 && cmb.any?{|i| board.position(i+1) == " "}
                  @move = cmb.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
                end
              end
      
              #If you can't make a winning combo, choose the next open space prioritizing corners then sides
              @move = (CORNERS && SIDES).find{|i| !board.taken?(i)}.to_s if @move == nil
            end
            @move
          end
    end
end