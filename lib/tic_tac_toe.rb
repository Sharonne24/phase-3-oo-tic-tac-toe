class TicTacToe
    attr_accessor :board
  
    WIN_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], #row
      [0, 3, 6], [1, 4, 7], [2, 5, 8], #column
      [0, 4, 8], [2, 4, 6]             #diagonal
    ]
  
    def initialize
      @board = Array.new(9, " ")#length of 9 and strings for each value of the element
    end
  #prints current board representation. string interpolation is used to display the board's cells in a grid format.
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

      def input_to_index(input) #converts users input into corresponding index in the @board's array.
        input.to_i - 1
      end
    
      def move(index, token = "X")#updates the player's move on the board
        @board[index] = token
      end
      def position_taken?(index)#checks if the position is taken or not
        @board[index] != " "
      end
    
      def valid_move?(index)#checks if the move is valid based on the specified position of the board
        index.between?(0, 8) && !position_taken?(index)
      end
    
      def turn_count #counts the number of turns that have been played by counting the number of non-empty cells on the board
        @board.count { |cell| cell != " " }
      end
    
      def current_player # determines the number of turns played by the current player
        turn_count % 2 == 0 ? "X" : "O"
      end
      def turn
        puts "Please enter a position between 1-9:"
        input = gets.strip
        index = input_to_index(input)
    
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
          puts "Invalid move. Please try again."
          turn
        end
      end
    
      def won?
        WIN_COMBINATIONS.each do |combo|
          position_1 = @board[combo[0]]
          position_2 = @board[combo[1]]
          position_3 = @board[combo[2]]
    
          if position_1 == position_2 && position_2 == position_3 && position_taken?(combo[0])
            return combo
          end
        end
    
        false
      end
    
      def full?
        @board.all? { |cell| cell != " " }
      end
    
      def draw?
        full? && !won?
      end
    
      def over?
        won? || draw?
      end
    
      def winner
        if combo = won?
          @board[combo[0]]
        end
      end
    
      def play
        until over?
          turn
        end
      
        if won?
          puts "Congratulations #{winner}!"
        else
          puts "Cat's Game!"
        end
      end
    end      
  