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
      arabic_to_roman
    elsif (value.match(/^[IVXLCDM]+$/))
      roman_to_arabic
    else
      "Input not recognised as valid arabic or roman number."
    end
  end

  def arabic_to_roman
    intval = value.to_i

    if (1..3999).include?(intval) # valid range
      units = intval % 10
      tens = (intval / 10) % 10
      hundreds = (intval / 100) % 10
      thousands = (intval / 1000)
      ("M" * thousands) +
        arabic_digits_to_roman(hundreds, "C", "D", "M") +
        arabic_digits_to_roman(tens, "X", "L", "C") +
        arabic_digits_to_roman(units, "I", "V", "X")
    else
      "Invalid input range - can only represent whole numbers between 1 and 3999."
    end
  end

  def arabic_digits_to_roman(arabic, unit, five, ten)
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

  def roman_to_arabic
    roman = @value

    thousands = extract_roman_subgroup(roman,"M","M","M")
    hundreds = extract_roman_subgroup(roman[thousands.length..-1],"C", "D", "M")
    tens = extract_roman_subgroup(roman[(thousands.length+hundreds.length)..-1],"X", "L", "C")
    units = extract_roman_subgroup(roman[(thousands.length+hundreds.length+tens.length)..-1],"I", "V", "X")

    # get hundreds/tens/units
    1000 * thousands.length +
    100 * roman_digits_to_arabic(hundreds, "C", "D", "M") +
    10 * roman_digits_to_arabic(tens, "X", "L", "C") +
    roman_digits_to_arabic(units, "I", "V", "X")
  end

  def extract_roman_subgroup(subroman, unit, five, ten)
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

  def roman_digits_to_arabic(subroman, unit, five, ten)
    if (subroman == "#{unit}#{ten}")
      9
    elsif (subroman == "#{unit}#{five}")
      4
    else
      (subroman.chr == "#{five}") ? 5 : 0 + subroman.count("#{unit}")
    end
  end

end
