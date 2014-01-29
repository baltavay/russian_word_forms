module RussianWordForms  
  class Rules    
    @@rules=Hash.new {|h,k| h[k]=Hash.new {|h2,k2| h2[k2]=[]}}

    def initialize
      load_rules
    end    
    def load_file(file)      
      flag=""
      File.readlines(file).each do |line|
        command=line.chomp.split('#')[0] # get rid of comments
        
        if command&&command!=""
          command=command.split(" ")
          if command.count==2 # 
            case command[0]
            when "flag"
              flag=command[1][1..-2]              
            end
          elsif command.count>2 # command
            rule=command.join.split(">")                        
            @@rules[flag][rule[0]]<<rule[1]
          end          
        end
      end                          
    end

    def load_rules          
      files=Dir[File.dirname(__FILE__)+"/dictionaries/*.aff"]
      files.each do |file|        
        load_file file
      end      
    end

    def rules
      @@rules
    end
    

  end
end