module RussianWordForms
  class Rules
    class Rule
      attr_accessor :rule,:normal_suffix,:suffix
      def initialize(rule,normal_suffix,suffix)
        @rule = rule
        @normal_suffix = normal_suffix
        @suffix = suffix
      end
    end
    attr_accessor :rules,:rules_without_flags


    def initialize
      @rules = Hash.new {|h,k| h[k]=Hash.new {|h2,k2| h2[k2]=[]}}
      @rules_without_flags = Hash.new {|h2,k2| h2[k2]=[]}
      load_rules
    end

    def load_file(file)
      flag = ""
      File.readlines(file).each do |line|
        command,comments = line.chomp.split('#') # get rid of comments
        if command && !command.empty?
          if command.start_with? "flag"
            flag = command[6..-2]
          else
            rule,suffixes = command.split.join.split(">")
            normal_suffix,suffix = suffixes.split(",")
            normal_suffix = normal_suffix[1..-1] if normal_suffix[0] == '-'
            suffix=suffix[1..-1] if suffix && suffix[0] == '-'
            @rules[flag][rule] << Rule.new(rule,normal_suffix,suffix)
            @rules_without_flags[rule] << Rule.new(rule,normal_suffix,suffix)
          end
        end
      end
    end

    def load_rules
      files = Dir[File.dirname(__FILE__)+"/dictionaries/*.aff"]
      files.each do |file|
        load_file file
      end
    end



  end
end
