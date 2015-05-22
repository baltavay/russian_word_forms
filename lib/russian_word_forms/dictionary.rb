require "unicode"
module RussianWordForms

  class Dictionary

    attr_accessor :dictionary

    def initialize
      @dictionary = Hash.new
      load_dictionaries
    end

    def load_dictionary(file)
      File.readlines(file).each do |line|
        stem,flags = line.chomp.split('/')
        stem = Unicode::upcase stem
        stem.gsub!("Ё","Е")
        @dictionary[stem]=flags
      end
    end

    def load_dictionaries
      files = Dir[File.dirname(__FILE__)+"/dictionaries/*.dic"]
      files.each do |file|
        load_dictionary file
      end
    end

    def get_flags(word)
      @dictionary[word]      
    end

  end

end
