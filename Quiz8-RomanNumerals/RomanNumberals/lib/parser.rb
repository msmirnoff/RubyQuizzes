# To change this template, choose Tools | Templates
# and open the template in the editor.

class Parser
  attr_accessor :value, :result
  def initialize
    @value = gets.chomp.upcase
    @result = nil
  end

  def convert
    @result = if (value.match(/^[1-9]+[0-9]*$/))
      i2r
    elsif (value.match(/^[IVXLCDM]+$/))
      r2i
    else
      "Unrecognised Input."
    end
  end

  def i2r
    intval = value.to_i

    if (intval < 4000 && intval > 0) # valid range
      units = intval % 10
      tens = (intval / 10) % 10
      hundreds = (intval / 100) % 10
      thousands = (intval / 1000)
      ("M" * thousands) +
        unitsToRoman(hundreds, "C", "D", "M") +
        unitsToRoman(tens, "X", "L", "C") +
        unitsToRoman(units, "I", "V", "X")
    else
      "Invalid input range"
    end
  end

  def unitsToRoman(arabic, unit, five, ten)
    if (arabic == 9)
      "#{unit}#{ten}"
    elsif (arabic >= 5)
      "#{five}" + (unit.to_s * (arabic - 5))
    elsif (arabic == 4)
      "#{unit}#{five}"
    else
      "#{unit}" * arabic
    end
  end

  def r2i
    roman = @value

#    # slice into substrings, for each decimal power
#    thousands = 0
#    # get thousands
#    while (roman.chr == "M")
#      thousands += 1
#      roman=roman[1..-1]
#    end

    thousands = cutRoman(roman,"M","M","M")
    hundreds = cutRoman(roman[thousands.length..-1],"C", "D", "M")
    tens = cutRoman(roman[(thousands.length+hundreds.length)..-1],"X", "L", "C")
    units = cutRoman(roman[(thousands.length+hundreds.length+tens.length)..-1],"I", "V", "X")

    # get hundreds/tens/units
    1000 * thousands.length +
    100 * romanToArabic(hundreds, "C", "D", "M") +
    10 * romanToArabic(tens, "X", "L", "C") +
    romanToArabic(units, "I", "V", "X")
  end

  def cutRoman(subroman, unit, five, ten)
    match = ""
    subroman.each_char do |c|
      if [unit,five,ten].map(&:to_s).include?(c)
        # still correct letter
        match += c
      else
        break
      end
    end
    match
  end

  def romanToArabic(subroman, unit, five, ten)
    if (subroman == "#{unit}#{ten}")
      9
    elsif (subroman == "#{unit}#{five}")
      4
    else
      (subroman.chr == "#{five}") ? 5 : 0 + subroman.count("#{unit}")
    end
  end

end
