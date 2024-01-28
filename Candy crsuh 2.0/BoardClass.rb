require_relative("OrbsClass")


class Board
    attr_accessor :board, :score
    def initialize()
        @score=0
        @board=[]
        
        5.times(){@board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])}


    end

    def printBaord()
        for row in @board
            for element in row
            
            if (element.color=="Red"||element.color=="Blue")
                print(element,"  |   ")
            else
                print(element," |  ")
            end
            end
            puts
        end
    end
    def anyMatch?()
        begin
            @board.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
            if (@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3]&&@board[i][j]==@board[i][j+4])
                @score+=5
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3])
                @score+=4
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2])
                @score+=3
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i]&&@board[j][i]==@board[j+4][i])
                @score+=5
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i])
                @score+=4 
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i])
                @score+=3
                return true
            end
            
            if(@board[i][j]==nil|| @board[i][j+1]==nil||@board[i][j+2]==nil||@board[i][j+3]==nil||@board[i][j+4]==nil)
            break
            end
            }
            
            }
        rescue NoMethodError
            puts("Error")
            return false
        end
        return false
    end
    def moveAllowed?(row,column,direction)
        return true if self.anyMatch?();
        direction.downcase!;
        case direction
        when "up"
            temp=@board[row-1][column];
            @board[row-1][column]=@board[row][column];
            @board[row][column]=temp;
            puts("can't match");
        when "down"

            temp=@board[row+1][column];
            @board[row+1][column]=@board[row][column];
            @board[row][column]=temp;
            puts("can't match");

        when "right"
            temp=@board[row][column+1];
            @board[row][column+1]=@board[row][column];
            @board[row][column]=temp;
            puts("can't match");

        when "left"
            temp=@board[row][column];
            @board[row][column]=@board[row][column-1];
            @board[row][column-1]=temp;
            puts("can't match");
        end
        
    end
    def move(row,column,direction)
        direction.downcase!

        case direction
        when "up"
            temp=@board[row-1][column];
            @board[row-1][column]=@board[row][column];
            @board[row][column]=temp;
            self.moveAllowed?(row,column,direction)

        when "down"
            temp=@board[row+1][column];
            @board[row+1][column]=@board[row][column];
            @board[row][column]=temp
            self.moveAllowed?(row,column,direction)
            
        when "right"
            temp=@board[row][column+1]
            @board[row][column+1]=@board[row][column]
            @board[row][column]=temp
            self.moveAllowed?(row,column,direction)

        when "left"
            temp=@board[row][column]
            @board[row][column]=@board[row][column-1]
            @board[row][column-1]=temp
            self.moveAllowed?(row,column,direction)
        end

    end
    def removeOrbs()
end



board=Board.new();

board.printBaord
print ("Row ")

row=gets.chomp.to_i

print ("Column ")
column=gets.chomp.to_i

print("Direction ")
direction=gets.chomp

board.move(row,column,direction)

board.printBaord

puts board.score()