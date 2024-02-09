require_relative("OrbsClass")


class Board
    attr_accessor :board, :score
    def initialize()
        @score=0
        @board=[]
        @board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])
        @board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])
        @board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])
        @board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])
        1.times(){@board.push([Orb.new("Yellow"),Orb.new("Yellow"),Orb.new(),Orb.new("Yellow"),Orb.new()])}


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
            @board.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
            begin
            if (@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3]&&@board[i][j]==@board[i][j+4])
                @score+=5
                puts("Match!!")
                removeOrbs(j,i,j,"row",5)
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3])
                @score+=4
                puts("Match!!")
                removeOrbs(j,i,j,"row",4)
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2])
                @score+=3
                puts("Match!!")
                removeOrbs(j,i,j,"row",3)
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i]&&@board[j][i]==@board[j+4][i])
                @score+=5
                puts("Match!!")
                removeOrbs(j,i,i,"column",5)
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i])
                @score+=4 
                puts("Match!!")
                removeOrbs(j,i,i,"column",4)
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i])
                @score+=3
                puts("Match!!")
                removeOrbs(j,i,i,"column",3)
                return true
            end
            
            rescue NoMethodError
                
                next
            end 
            }
            
            }
        
        return false
    end

    
    
    def moveAllowed?(row,column,direction)
        if (anyMatch?()==true)
            until anyMatch?()==false
                anyMatch?()
            end
            
        else    
            
            #return true if self.anyMatch?();
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
        
                if(@board[rowIndex+1][orbsStartIndex].nil?)
                    @board[rowIndex][orbsStartIndex]=Orb.new()
                    @board[rowIndex][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex][orbsStartIndex+2]=Orb.new()
                else
                    @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex];
                    @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1];
                    @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+1][orbsStartIndex+2];
                    
                    
                    if(@board[rowIndex+2][orbsStartIndex].nil?)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                    end
                    
                    if(@board[rowIndex+3][orbsStartIndex].nil?)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                        end

                        if(@board[rowIndex+4][orbsStartIndex].nil?)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex+4][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex+4][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex+4][orbsStartIndex+2]
                        end

                    @board[rowIndex+4][orbsStartIndex]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+2]=Orb.new()
                end
                        
                    


            when 4
                if(@board[rowIndex+1][orbsStartIndex].nil?)
                    @board[rowIndex][orbsStartIndex]=Orb.new()
                    @board[rowIndex][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex][orbsStartIndex+3]=Orb.new()
                else
                    @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex];
                    @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1];
                    @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+1][orbsStartIndex+2];
                    @board[rowIndex][orbsStartIndex+3]=@board[rowIndex+1][orbsStartIndex+3];
                    
                    
                    if(@board[rowIndex+2][orbsStartIndex].nil?)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                        @board[rowIndex+1][orbsStartIndex+3]=@board[rowIndex+2][orbsStartIndex+3]
                    end
                    
                    if(@board[rowIndex+3][orbsStartIndex].nil?)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                            @board[rowIndex+2][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+3]
                        end

                        if(@board[rowIndex+4][orbsStartIndex].nil?)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex+4][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex+4][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex+4][orbsStartIndex+2]
                                @board[rowIndex+3][orbsStartIndex+3]=@board[rowIndex+4][orbsStartIndex+3]
                        end

                    @board[rowIndex+4][orbsStartIndex]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+3]=Orb.new()
                end

            when 5
                if(@board[rowIndex+1][orbsStartIndex].nil?)
                    @board[rowIndex][orbsStartIndex]=Orb.new()
                    @board[rowIndex][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex][orbsStartIndex+3]=Orb.new()
                    @board[rowIndex][orbsStartIndex+4]=Orb.new()
                else
                    @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex];
                    @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1];
                    @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+1][orbsStartIndex+2];
                    @board[rowIndex][orbsStartIndex+3]=@board[rowIndex+1][orbsStartIndex+3];
                    @board[rowIndex][orbsStartIndex+4]=@board[rowIndex+1][orbsStartIndex+4];
                    
                    
                    if(@board[rowIndex+2][orbsStartIndex].nil?)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                        @board[rowIndex+1][orbsStartIndex+3]=@board[rowIndex+2][orbsStartIndex+3]
                        @board[rowIndex+1][orbsStartIndex+4]=@board[rowIndex+2][orbsStartIndex+4]
                    end
                    
                    if(@board[rowIndex+3][orbsStartIndex].nil?)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                            @board[rowIndex+2][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+3]
                            @board[rowIndex+2][orbsStartIndex+4]=@board[rowIndex+3][orbsStartIndex+4]
                        end

                        if(@board[rowIndex+4][orbsStartIndex].nil?)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex+4][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex+4][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex+4][orbsStartIndex+2]
                                @board[rowIndex+3][orbsStartIndex+3]=@board[rowIndex+4][orbsStartIndex+3]
                                @board[rowIndex+3][orbsStartIndex+4]=@board[rowIndex+4][orbsStartIndex+4]
                        end

                    @board[rowIndex+4][orbsStartIndex]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+3]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+4]=Orb.new()
                end
        end

    end
    def removeOrbsColumnHelper(orbsStartIndex,columnIndex,amount)
        case amount
        when 3

            case orbsStartIndex
            
            when 0

                @board[orbsStartIndex][columnIndex]=@board[orbsStartIndex+3][columnIndex]
                @board[orbsStartIndex+1][columnIndex]=@board[orbsStartIndex+4][columnIndex]
                orbsStartIndex+=2
                3.times(){
                    @board[orbsStartIndex][columnIndex]=Orb.new()
                    orbsStartIndex+=1
                    

                }
            when 1
                @board[orbsStartIndex][columnIndex]=@board[orbsStartIndex+4][columnIndex]
                orbsStartIndex+=1
                3.times(){
                    @board[orbsStartIndex][columnIndex]=Orb.new();
                    orbsStartIndex+=1
                }

            when 2
                
                3.times(){
                    @board[orbsStartIndex][columnIndex]=Orb.new();
                    orbsStartIndex+=1
                }
            end

            
            
        when 4
            
            case orbsStartIndex
            when 0
                @board[orbsStartIndex][columnIndex]=@board[orbsStartIndex+4][columnIndex]

                orbsStartIndex+=1
                4.times(){
                    @board[orbsStartIndex][columnIndex]=Orb.new()
                    orbsStartIndex+=1
                }
            when 1
                4.times(){
                    @board[orbsStartIndex][columnIndex]=Orb.new()
                    orbsStartIndex+=1
                }
            end

        when 5
            @board[orbsStartIndex][columnIndex]=Orb.new()
            @board[orbsStartIndex+1][columnIndex]=Orb.new()
            @board[orbsStartIndex+2][columnIndex]=Orb.new()
            @board[orbsStartIndex+3][columnIndex]=Orb.new()
            @board[orbsStartIndex+4][columnIndex]=Orb.new()

        end
    end
   def removeOrbs(orbsStartIndex,rowIndex,columnIndex,direction,amount)
       direction.downcase!
       case direction
       
        when "row"
           removeOrbsRowHelper(orbsStartIndex,rowIndex,amount)
        when "column"
            removeOrbsColumnHelper(orbsStartIndex,columnIndex,amount)
        end
    end
end



board=Board.new();
# 5.times(){
board.printBaord
print ("Row ")

# row=gets.chomp.to_i
row=4
print ("Column ")
# column=gets.chomp.to_i
column =3
print("Direction ")
# direction=gets.chomp
direction="left"
board.move(row,column,direction)
puts
puts
puts
board.printBaord

puts
puts
puts
# }
puts board.score()