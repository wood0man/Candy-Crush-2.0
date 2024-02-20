require_relative("OrbsClass")


class Board
    attr_accessor :board, :score
    def initialize()
        @score=0
        @board=[]
        @board.push([Orb.new("Blue"),Orb.new("Purple"),Orb.new("Red"),Orb.new("Blue"),Orb.new("Yellow")])
        @board.push([Orb.new("Yellow"),Orb.new("Green"),Orb.new("Green"),Orb.new("Purple"),Orb.new("Red")])
        @board.push([Orb.new("Red"),Orb.new("Red"),Orb.new("Blue"),Orb.new("Yellow"),Orb.new("Blue")])
        @board.push([Orb.new("Purple"),Orb.new("Green"),Orb.new("Purple"),Orb.new("Green"),Orb.new("Purple")])
        1.times(){@board.push([Orb.new("Yellow"),Orb.new("Yellow"),Orb.new("Red"),Orb.new("Green"),Orb.new("Purple")])}
        # 5.times(){@board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])}

       until(doesBoardHasAPotionalMatch?()==true)
            refresh()
        
       end
       puts("There are no matches in the board. Let's fix that!! Refresh!!")
       initialAnyMatch?()

    end
    def printBaord()
        
        @board.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
               begin
                 if(element.color=="Red"||element.color=="Blue")
                    print(element,"  |   ")
                else
                    print(element," |  ")
            
                end
                rescue NoMethodError =>e
                  element=Orb.new()
               
               end
            }   
                puts
        }
               
            
    end

    def initialAnyMatch?()
        @board.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
            
            if (@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3]&&@board[i][j]==@board[i][j+4])
            #    puts("Initial match at i:#{i} j:#{j}")
                removeOrbs(j,i,j,"row",5)
                
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3])
                # puts("Initial match at i:#{i} j:#{j}")

                removeOrbs(j,i,j,"row",4)
                
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2])
                # puts("Initial match at i:#{i} j:#{j}")

                removeOrbs(j,i,j,"row",3)
                
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i]&&@board[j][i]==@board[j+4][i])
                # puts("Initial match at i:#{i} j:#{j}")

                removeOrbs(j,i,i,"column",5)
                
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i])
                # puts("Initial match at i:#{i} j:#{j}")

                removeOrbs(j,i,i,"column",4)
                
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i])
                # puts("Initial match at i:#{i} j:#{j}")

                removeOrbs(j,i,i,"column",3)
                
            end
            
            
            }
            
        }
       
    
    end
    def anyMatch?()
            # puts("In the begining of the anymatch?")
            @board.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
            begin
            if (@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3]&&@board[i][j]==@board[i][j+4])
                @score+=5
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in row for 5 points")
                removeOrbs(j,i,j,"row",5)
                # puts("Reached the return")
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2]&& @board[i][j]==@board[i][j+3])
                @score+=4
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in row for 4 points")
                removeOrbs(j,i,j,"row",4)
                # puts("Reached the return")
                return true
            elsif(@board[i][j]==@board[i][j+1]&&@board[i][j]==@board[i][j+2])
                @score+=3
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in row for 3 points")
                removeOrbs(j,i,j,"row",3)
                # puts("Reached the return")
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i]&&@board[j][i]==@board[j+4][i])
                @score+=5
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in column for 5 points")
                removeOrbs(j,i,i,"column",5)
                # puts("Reached the return")
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i]&&@board[j][i]==@board[j+3][i])
                @score+=4 
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in column for 4 points")
                removeOrbs(j,i,i,"column",4)
                # puts("Reached the return")
                return true
            elsif(@board[j][i]==@board[j+1][i]&&@board[j][i]==@board[j+2][i])
                @score+=3
                puts("Match!!")
                # puts("Match at i:#{i} j:#{j} in column for 3 points")
                removeOrbs(j,i,i,"column",3)
                # puts("Reached the return")
                return true
            end
            
            rescue NoMethodError =>e
                # puts("#{e.message()}")
                # puts("Error at i:#{i} j:#{j} in orb #{@board[j][i]}")

                next
            end 
            # print(@board[j][i]," ",@board[j+1][i]," ",@board[j+2][i])
            # puts
            
            }

            
            }
        # puts("Reached the return of the anymatch")
        return false
    end

    
    
    def moveAllowed?(row,column,direction)
        # puts("In the begining of the moveAllowed?")
        puts
        
        if (anyMatch?())
            until anyMatch?()==false
                #do nothing
            end
            return true
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
        # puts("reached the return of the moveAllowed?")
    end
    def move(row,column,direction)
    # puts("In the begining of the move")
        direction.downcase!

        case direction
        when "up"
            if (@board[row-1][column]==nil)
                return
            end
            temp=@board[row-1][column];
            @board[row-1][column]=@board[row][column];
            @board[row][column]=temp;
            
            self.moveAllowed?(row,column,direction)

        when "down"
            if (@board[row+1][column]==nil)
                return
            end
            temp=@board[row+1][column];
            @board[row+1][column]=@board[row][column];
            @board[row][column]=temp
            
            self.moveAllowed?(row,column,direction)
            
        when "right"
            if (@board[row][column+1]==nil)
                return
            end
            temp=@board[row][column+1]
            @board[row][column+1]=@board[row][column]
            @board[row][column]=temp
            
            self.moveAllowed?(row,column,direction)

        when "left"
            if (@board[row][column-1]==nil)
                return
            end
            temp=@board[row][column]
            @board[row][column]=@board[row][column-1]
            @board[row][column-1]=temp
            
            self.moveAllowed?(row,column,direction)
        end
        until(doesBoardHasAPotionalMatch?()==true)
            refresh()
        
       end
       puts("There are no matches in the board. Let's fix that!! Refresh!!")
       initialAnyMatch?()
    end

    def removeOrbsRowHelper(orbsStartIndex,rowIndex,amount)
        case amount
            when 3
                if(@board[rowIndex+1]==nil)
                    @board[rowIndex][orbsStartIndex]=Orb.new()
                    @board[rowIndex][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex][orbsStartIndex+2]=Orb.new()
                else
                    @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex];
                    @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1];
                    @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+1][orbsStartIndex+2];
                    
                    
                    if(@board[rowIndex+2]==nil)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                    end
                    
                    if(@board[rowIndex+3]==nil)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                        end

                        if(@board[rowIndex+4]==nil)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex+4][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex+4][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex+4][orbsStartIndex+2]
                        end

                    @board[rowIndex-1][orbsStartIndex]=Orb.new()
                    @board[rowIndex-1][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex-1][orbsStartIndex+2]=Orb.new()
                end
                        
                    


            when 4
                if(@board[rowIndex+1]==nil)
                    @board[rowIndex][orbsStartIndex]=Orb.new()
                    @board[rowIndex][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex][orbsStartIndex+3]=Orb.new()
                else
                    @board[rowIndex][orbsStartIndex]=@board[rowIndex+1][orbsStartIndex];
                    @board[rowIndex][orbsStartIndex+1]=@board[rowIndex+1][orbsStartIndex+1];
                    @board[rowIndex][orbsStartIndex+2]=@board[rowIndex+1][orbsStartIndex+2];
                    @board[rowIndex][orbsStartIndex+3]=@board[rowIndex+1][orbsStartIndex+3];
                    
                    
                    if(@board[rowIndex+2]==nil)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                        @board[rowIndex+1][orbsStartIndex+3]=@board[rowIndex+2][orbsStartIndex+3]
                    end
                    
                    if(@board[rowIndex+3]==nil)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                            @board[rowIndex+2][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+3]
                        end

                        if(@board[rowIndex+4]==nil)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex-1][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex-1][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex-1][orbsStartIndex+2]
                                @board[rowIndex+3][orbsStartIndex+3]=@board[rowIndex-1][orbsStartIndex+3]
                        end

                    @board[-1][orbsStartIndex]=Orb.new()
                    @board[-1][orbsStartIndex+1]=Orb.new()
                    @board[-1][orbsStartIndex+2]=Orb.new()
                    @board[-1][orbsStartIndex+3]=Orb.new()
                end

            when 5
                if(@board[rowIndex+1]==nil)
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
                    @board[rowIndex][orbsStartIndex+4]=@board[rowIndex+1][orbsStartIndex-1];
                    
                    
                    if(@board[rowIndex+2]==nil)
                    #do nothing
                    else
                        @board[rowIndex+1][orbsStartIndex]=@board[rowIndex+2][orbsStartIndex]
                        @board[rowIndex+1][orbsStartIndex+1]=@board[rowIndex+2][orbsStartIndex+1]
                        @board[rowIndex+1][orbsStartIndex+2]=@board[rowIndex+2][orbsStartIndex+2]
                        @board[rowIndex+1][orbsStartIndex+3]=@board[rowIndex+2][orbsStartIndex+3]
                        @board[rowIndex+1][orbsStartIndex-1]=@board[rowIndex+2][orbsStartIndex-1]
                    end
                    
                    if(@board[rowIndex+3]==nil)
                        #do nothing
                        else
                            @board[rowIndex+2][orbsStartIndex]=@board[rowIndex+3][orbsStartIndex]
                            @board[rowIndex+2][orbsStartIndex+1]=@board[rowIndex+3][orbsStartIndex+1]
                            @board[rowIndex+2][orbsStartIndex+2]=@board[rowIndex+3][orbsStartIndex+2]
                            @board[rowIndex+2][orbsStartIndex+3]=@board[rowIndex+3][orbsStartIndex+3]
                            @board[rowIndex+2][orbsStartIndex-1]=@board[rowIndex+3][orbsStartIndex-1]
                        end

                        if(@board[rowIndex+4]==nil)
                            #do nothing
                            else
                                @board[rowIndex+3][orbsStartIndex]=@board[rowIndex+4][orbsStartIndex]
                                @board[rowIndex+3][orbsStartIndex+1]=@board[rowIndex+4][orbsStartIndex+1]
                                @board[rowIndex+3][orbsStartIndex+2]=@board[rowIndex+4][orbsStartIndex+2]
                                @board[rowIndex+3][orbsStartIndex+3]=@board[rowIndex+4][orbsStartIndex+3]
                                @board[rowIndex+3][orbsStartIndex-1]=@board[rowIndex-1][orbsStartIndex-1]
                        end

                    @board[rowIndex+4][orbsStartIndex]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+1]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex+2]=Orb.new()
                    @board[rowIndex+4][orbsStartIndex-2]=Orb.new()
                    @board[rowIndex-1][orbsStartIndex-1]=Orb.new()
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
                @board[orbsStartIndex][columnIndex]=@board[orbsStartIndex-1][columnIndex]

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
            @board[orbsStartIndex-2][columnIndex]=Orb.new()
            @board[orbsStartIndex-1][columnIndex]=Orb.new()

        end
        # puts("Reached the return of columnHelper")
        
    end
   def removeOrbs(orbsStartIndex,rowIndex,columnIndex,direction,amount)
    # puts("In the begining of the removeOrbs")
       direction.downcase!
       case direction
       
        when "row"
           removeOrbsRowHelper(orbsStartIndex,rowIndex,amount)
        when "column"
            removeOrbsColumnHelper(orbsStartIndex,columnIndex,amount)
        end
        # puts("Reached the return of removeOrbs")
        
    end
    def doesBoardHasAPotionalMatch?()
        copy=@board.dup();
        copy.each_with_index(){|row,i|
            row.each_with_index(){|element,j|
                if (copyMove(i,j,"up",copy))
                    return true
                elsif(copyMove(i,j,"down",copy))
                    return true
                elsif(copyMove(i,j,"right",copy))
                    return true
                elsif(copyMove(i,j,"left",copy))
                    return true
                end
            }
        }
        return false
    
    end
    def copyMove(row,column,direction,copy)

        direction.downcase!

        case direction
            
        when "up"
            if(copy[row-1][column]==nil)
                return false
            end
            temp=copy[row-1][column];
            copy[row-1][column]=copy[row][column];
            copy[row][column]=temp;
            
            copyMoveAllowed(row,column,direction,copy)

        when "down"
            if(copy[row+1][column]==nil)
                return false
            end
            temp=copy[row+1][column];
            copy[row+1][column]=copy[row][column];
            copy[row][column]=temp
            
            copyMoveAllowed(row,column,direction,copy)
            
        when "right"
            if(copy[row][column+1]==nil)
                return false
            end
            temp=copy[row][column+1]
            copy[row][column+1]=copy[row][column]
            copy[row][column]=temp
            
            copyMoveAllowed(row,column,direction,copy)

        when "left"
            if(copy[row][column-1]==nil)
                return false
            end
            temp=copy[row][column]
            copy[row][column]=copy[row][column-1]
            copy[row][column-1]=temp
            
            copyMoveAllowed(row,column,direction,copy)
    end

    


    end
    def copyMoveAllowed(row,column,direction,copy)
        
        return true if copyAnyMatch?(copy);
        direction.downcase!;
       
       
        case direction
        when "up"
            if(copy[row-1][column]==nil)
                return false
            end
            temp=copy[row-1][column];
            copy[row-1][column]=copy[row][column];
            copy[row][column]=temp;
            return false
        when "down"
            if(copy[row+1][column]==nil)
                return false
            end
            temp=copy[row+1][column];
            copy[row+1][column]=copy[row][column];
            copy[row][column]=temp;
            return false
        when "right"
            if(copy[row][column+1]==nil)
                return false
            end
            temp=copy[row][column+1];
            copy[row][column+1]=copy[row][column];
            copy[row][column]=temp;
            return false
        when "left"
            if(copy[row][column-1]==nil)
                return false
            end
            temp=copy[row][column];
            copy[row][column]=copy[row][column-1];
            copy[row][column-1]=temp;
            return false
        end
    end
    def copyAnyMatch?(copy)
        copy.each_with_index(){|row,i|
        row.each_with_index(){|element,j|
        begin
        if (copy[i][j]==copy[i][j+1]&&copy[i][j]==copy[i][j+2]&& copy[i][j]==copy[i][j+3]&&copy[i][j]==copy[i][j+4])
           
            
            
            return true
        elsif(copy[i][j]==copy[i][j+1]&&copy[i][j]==copy[i][j+2]&&copy[i][j]==copy[i][j+3])
            
           
            
            return true
        elsif(copy[i][j]==copy[i][j+1]&&copy[i][j]==copy[i][j+2])
            
            
            return true
        elsif(copy[j][i]==copy[j+1][i]&&copy[j][i]==copy[j+2][i]&&copy[j][i]==copy[j+3][i]&&copy[j][i]==copy[j+4][i])
            
            
            return true
        elsif(copy[j][i]==copy[j+1][i]&&copy[j][i]==copy[j+2][i]&&copy[j][i]==copy[j+3][i])
           

            return true
        elsif(copy[j][i]==copy[j+1][i]&&copy[j][i]==copy[j+2][i])
            

            return true
        end
        
        rescue NoMethodError =>e
            # puts("#{e.message()}")
            # puts("Error at i:#{i} j:#{j} in orb #{@board[j][i]}")

            next
        end 
        # print(@board[j][i]," ",@board[j+1][i]," ",@board[j+2][i])
        # puts
        
        }

        
        }
    # puts("Reached the return of the anymatch")
    return false
    end
    
    def refresh()
        5.times(){@board.pop()}
        5.times(){@board.push([Orb.new(),Orb.new(),Orb.new(),Orb.new(),Orb.new()])}

    end
end
    






board=Board.new();
board.printBaord
5.times(){

 print ("Row ")
row=gets.chomp.to_i
# row=1
print ("Column ")
column=gets.chomp.to_i
# column =4
print("Direction ")
direction=gets.chomp
# direction="down"
board.move(row,column,direction)
puts
puts
puts
board.printBaord

puts
puts
puts
}
puts ("#{board.score()} Points!!")