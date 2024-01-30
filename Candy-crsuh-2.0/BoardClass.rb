require_relative("OrbsClass")


class Board
    attr_accessor :board, :score
    def initialize()
        @score=0
        @board=[]
        @board.push([Orb.new(),Orb.new("Red"),Orb.new(),Orb.new("Red"),Orb.new("Red")])
        4.times(){@board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])}


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
            
            
            #to check if the "j" goes out of bounds becasue it causes an error
            if(@board[j]==nil)
                next
            end
            if (@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3]&&@board[i][j]==@board[i][j+4])
                @score+=5
                puts("Match!!")
                removeOrbs(j,i,"row",5)
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3])
                @score+=4
                puts("Match!!")
                removeOrbs(j,i,"row",4)
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2])
                @score+=3
                puts("Match!!")
                removeOrbs(j,i,"row",3)
                return true
                
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i]&&@board[j][i]==@board[j+4][i])
                @score+=5
                puts("Match!!")
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i])
                @score+=4 
                puts("Match!!")
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i])
                @score+=3
                puts("Match!!")
                return true
            end
            
            
            }
            
            }
        rescue => e
            e.message
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


    def removeOrbsRowHelper(orbsStartIndex,rowIndex,amount)

        case amount
            when 3
                @board.each_with_index(){|row,i|
                    row.each_with_index(){|element,j|
                        if (@board[rowIndex+1][orbsStartIndex]==nil || @board[rowIndex][orbsStartIndex+1]==nil)
                            @board[rowIndex][orbsStartIndex]=Orb.new();
                            @board[rowIndex][orbsStartIndex+1]=Orb.new();
                            @board[rowIndex][orbsStartIndex+2]=Orb.new();
                            break
                        else
                            @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex]
                            @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1]

                            if(@board[rowIndex][orbsStartIndex+2]==nil||@board[rowIndex][orbsStartIndex+2]==nil)
                                next
                            else
                            @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                            end
                        end
                    }  
                
                }


            when 4
                @board.each_with_index(){|row,i|
                    row.each_with_index(){|element,j|
                        if (@board[rowIndex+1][orbsStartIndex]==nil || @board[rowIndex][orbsStartIndex+1]==nil)
                            @board[rowIndex][orbsStartIndex]=Orb.new();
                            @board[rowIndex][orbsStartIndex+1]=Orb.new();
                            @board[rowIndex][orbsStartIndex+2]=Orb.new();
                            @board[rowIndex][orbsStartIndex+3]=Orb.new();
                            break
                        else
                            @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex]
                            @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1]
                            @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+1]

                            if(@board[rowIndex][orbsStartIndex+2]==nil||@board[rowIndex][orbsStartIndex+2]==nil)
                                next
                            else
                                @board[rowIndex][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+2]
                            end
                        end
                    }   
                
                }

            when 5
                @board.each_with_index(){|row,i|
                row.each_with_index(){|element,j|
                    if (@board[rowIndex+1][orbsStartIndex]==nil || @board[rowIndex][orbsStartIndex+1]==nil)
                        @board[rowIndex][orbsStartIndex]=Orb.new();
                        @board[rowIndex][orbsStartIndex+1]=Orb.new();
                        @board[rowIndex][orbsStartIndex+2]=Orb.new();
                        @board[rowIndex][orbsStartIndex+3]=Orb.new();
                        @board[rowIndex][orbsStartIndex+4]=Orb.new();
                        break
                    else
                        @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex]
                        @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1]
                        @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+1]

                        if(@board[rowIndex][orbsStartIndex+2]==nil||@board[rowIndex][orbsStartIndex+2]==nil)
                            next
                        else
                        @board[rowIndex][orbsStartIndex+4]=@board[rowIndex+4][orbsStartIndex+2]
                        end
                    end
                }   
            
            }
        end

    end





    def removeOrbs(orbsStartIndex,rowIndex,direction,amount)
       direction.downcase!
       case direction
       
        when "row"
           removeOrbsRowHelper(orbsStartIndex,rowIndex,amount)
       end
    end

end



board=Board.new();
5.times(){
board.printBaord
print ("Row ")

# row=gets.chomp.to_i
row=0
print ("Column ")
# column=gets.chomp.to_i
column =1
print("Direction ")
# direction=gets.chomp
direction="right"
board.move(row,column,direction)
puts
puts
puts
board.printBaord

puts
puts
puts
}
puts board.score()