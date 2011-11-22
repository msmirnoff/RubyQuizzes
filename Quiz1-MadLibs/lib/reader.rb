# To change this template, choose Tools | Templates
# and open the template in the editor.

class Reader

  attr_accessor :story, :args
  def initialize(story)
    @story = story.chomp
    extractPlaceholders
  end

  def extractPlaceholders
    @args = @story.gsub(/[\(]{2}/,"(arg)(swap)").gsub(/[\)]{2}/,"(arg)").split("(arg)")
  end

  def getAnswers
    answer = ""
    syms = Hash.new
    args.each do |arg|
      if arg.start_with?("(swap)")
        argval = arg.sub("(swap)","")
        if (syms.has_key?(argval)) # we have this key-value already
          keystring = argval
        elsif (argval.include? ":")
          keystring = argval.split(":").fetch(0)
          print "Please choose " + argval.sub(/[A-z]+:/,"") + ": "
          syms[keystring] = gets.chomp
        else
          keystring = argval
          print "Please choose " + argval + ": "
          syms[keystring] = gets.chomp
        end
        answer += syms[keystring]
      else
        answer += arg
      end
    end
    puts syms
    answer
  end

end
