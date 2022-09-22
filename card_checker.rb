class CardChecker
  # All Card References: black, red, green, blue
  CARD_REF = {
    "black": "60141",
    "red": "6014352",
    "green": ["6014355526", "6014355527", "6014355528", "6014355529"],
    "blue": "6014"
  }

  def initialize(card_number)
    @card_number ||= card_number.to_s
  end

  def call
    puts "#{recognize_card} : #{sanitized_numbers} #{validator}"
  end


  def recognize_card
    return "Fly Buys Black" if black?
    return "Fly Buys Red" if red?
    return "Fly Buys Green" if green?
    return "Fly Buys Blue" if blue?
    "Unknown"
  end

  def validator
   return "(invalid)" if unknown_card? || !multiple_of_ten?

   "(valid)"
  end

  def sanitized_numbers
    @card_number.delete("^0-9").to_s
  end

  private

  def dissected_numbers
    sanitized_numbers.to_s.split("").map(&:to_i)
  end

  def double_odd_and_split_numbers
    calculated_numbers = []

    dissected_numbers.each_with_index do |digit, index|
      index += 1
      integer = index.odd? ? digit * 2 : digit # step 1 : double the digits
      integer = integer.digits.sum if integer > 9 # step 2 : split the digits if > 9 [and get sum]
      calculated_numbers.push(integer)
    end

    calculated_numbers
  end

  def multiple_of_ten?
    double_odd_and_split_numbers.sum % 10 == 0 # step 3 : checks multiple of 10
  end

  def valid_length?(digits = 16)
    sanitized_numbers.length == digits
  end

  def unknown_card?
    recognize_card.include? "Unknown"
  end

  # Colors
  def black?
    sanitized_numbers.start_with?(CARD_REF[:black]) && (valid_length? || valid_length?(17))
  end

  def red?
    sanitized_numbers.start_with?(CARD_REF[:red]) && valid_length?
  end

  def green?
    sanitized_numbers.start_with?(*CARD_REF[:green]) && valid_length?
  end

  def blue?
    sanitized_numbers.start_with?(CARD_REF[:blue]) && valid_length?
  end
end

module CardCheckTest
  def self.call(card_number)
    CardChecker.new(card_number).call
  end
end