require "russian_word_forms/version"
require 'russian_word_forms/dictionary'
require 'russian_word_forms/rules'
module RussianWordForms
  @dictionary=Dictionary.new
  @rules=Rules.new
  
  def self.inflect(word)    
    word=word.mb_chars.upcase.to_s
    flags=@dictionary.dictionary[word]
    output=[]
    output<<word if !flags.kind_of?(Array)
    flags=@rules.rules.keys.join if flags.kind_of?(Array)&&flags.empty? # if not found in dictionary 
    flags.each_char do |flag|
      rules=@rules.rules[flag]
      rules.keys.each do |rule|
        rules[rule].each do |affix|
          left,right=affix.split(",")          
          if right
            left=left[1..-1] if left[0]=='-'
            right=right[1..-1] if right[0]=='-'
            
            output<<word.gsub(/(#{left})$/,right) if word.match(/(#{rule})$/)
          else

            output<<word+left if word.match(/(#{rule})$/)
          end

        end
      end  
    end
    output.uniq
  end
  def self.get_base_form(word)
    word=word.mb_chars.upcase.to_s
    flags=@dictionary.dictionary[word]
    variants=[]
    variants<<word if !flags.kind_of?(Array)
    @rules.rules.keys.each do |flag|
      rules=@rules.rules[flag]
      rules.keys.each do |rule|
        rules[rule].each do |affix|
          left,right=affix.split(",")          
          if right
            left=left[1..-1] if left[0]=='-'
            right=right[1..-1] if right[0]=='-'
            if word.match(/(#{right})$/)
              tmp=word.gsub(/(#{right})$/,left)
              variants<< tmp if tmp.match(/(#{rule})$/)
            end
          else
            if word.match(/(#{left})$/)
              tmp=word.gsub(/(#{left})$/,"")
              variants<<tmp if tmp.match(/(#{rule})$/)
            end
          end
        end
      end
    end
    output=[]
    variants.each do |variant|
      if !@dictionary.dictionary[variant].kind_of?(Array)&&self.inflect(variant).any? { |w| w==word }
        output<<variant
      end
    end
    return output.uniq
  end
  
  def self.rules
    @rules
  end
  
  def self.dictionary
    @dictionary
  end
end
