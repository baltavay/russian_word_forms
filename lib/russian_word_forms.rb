require "russian_word_forms/version"
require 'russian_word_forms/dictionary'
require 'russian_word_forms/rules'
require "unicode"

module RussianWordForms

  @@dictionary=Dictionary.new
  @@rules=Rules.new


  def self.inflect(word)
    word = Unicode::upcase(word)
    flags = @@dictionary.get_flags word
    output = []
    if flags
      flags.each_char do |flag|
        rules_keys = @@rules.rules[flag]
        rules_keys.each do |key,rules|
          rules.each do |rule|
            if rule.suffix
              output << word.gsub(/(#{rule.normal_suffix})$/i,rule.suffix) if word.match(/(#{rule.rule})$/i)
            else
              output << word+rule.normal_suffix if word.match(/(#{rule.rule})$/i)
            end

          end
        end
      end
    end
    output.uniq
  end
  def self.get_base_form(word)
    word = Unicode::upcase(word).to_s
    flags = @@dictionary.dictionary[word]
    variants = []
    variants << word if flags
    @@rules.rules.each do |flag,rules_keys|
      rules_keys.each do |key,rules|
        rules.each do |rule|
          if rule.suffix && !rule.suffix.empty?
            # puts "#{word} #{rule.suffix}"

            if word.end_with? rule.suffix
              tmp = word.gsub(rule.suffix,rule.normal_suffix)
              # puts tmp
              variants << tmp if tmp != word && tmp.match(/(#{rule.rule})$/i) && @@dictionary.get_flags(tmp)
            end

          else
            if word.end_with?(rule.normal_suffix)
              tmp = word.gsub(rule.normal_suffix,"")
              variants << tmp if tmp != word && tmp.match(/(#{rule.rule})$/i) && @@dictionary.dictionary[tmp]
            end
          end
        end
      end
    end


    return variants.uniq
  end

  def self.rules
    @@rules
  end

  def self.dictionary
    @@dictionary
  end
end
