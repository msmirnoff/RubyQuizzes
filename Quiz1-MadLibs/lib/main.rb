require './reader.rb'

story = "I had a ((an adjective)) sandwich for lunch today. " +
  "It dripped all over my ((a body part)) and ((a noun))."

reader = Reader.new(story)

puts "The story:"+reader.story

puts "Story component count: "+reader.args.length.to_s

puts "Story components:"
reader.args.each { |i| puts i }

puts "Now getting input: "

puts reader.getAnswers
