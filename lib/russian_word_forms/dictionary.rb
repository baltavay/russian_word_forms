module RussianWordForms  
  class Dictionary    
    @@dictionary=Hash.new {|h,k| h[k]=[]}

    def initialize
      load_dictionaries
    end    
    def load_dictionary(file)      
      File.readlines(file).each do |line|
        word=line.chomp.split('/')
        word[0]=word[0].mb_chars.upcase.to_s
        #
        word[0].gsub!("Ё","Е")
        if word.count>1            
          @@dictionary[word[0]]=word[1]
        else
          @@dictionary[word[0]]=""
        end
      end                          
    end

    def load_dictionaries            
      files=Dir[File.dirname(__FILE__)+"/dictionaries/*.dic"]
      files.each do |file|        
        load_dictionary file
      end      
    end

    def dictionary
      @@dictionary
    end
    

  end
end