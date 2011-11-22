require './reader.rb'

firstStory = "I had a ((an adjective)) sandwich for lunch today. " +
  "It dripped all over my ((a body part)) and ((a noun))."

secondStory = "Our favorite language is ((a gemstone))."

thirdStory = "Our favorite language is ((gem:a gemstone)). " +
  "We think ((gem)) is better than ((a gemstone))."

#reader1 = Reader.new(firstStory)
#puts reader1.getAnswers
#
#reader2 = Reader.new(secondStory)
#puts reader2.getAnswers

reader3 = Reader.new(thirdStory)

puts reader3.getAnswers
