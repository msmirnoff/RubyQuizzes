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
    args.each do |arg|
      if (arg.start_with?("(swap)"))
        print "Please choose an " + arg.sub("(swap)","") + ": "
        answer += gets.chomp
      else
        answer += arg
      end
    end
    answer
  end

end
