require "minitest/autorun"
require "./card_checker"

class CardCheckerTest < Minitest::Test

  VALID_CARD = "6014355510000028"
  INVALID_CARD = "6014365510000028"

  CARD_SAMPLES = [
    "60141016700078611",
    "6014152705006141",
    "6014111100033006",
    "6014709045001234",
    "6014352700000140",
    "6014355526000020",
    "6014 3555 2900 0028",
    "6013111111111111"
  ]
  
  
  UNTIDY_SAMPLES = [
    "6014-101670-007---8611",
    "   6014152705006141",
    "---!6014111100033006",
    "---!60141111000330060abc",
  ]
  
  puts "\n #{"*"*20}  Sample Cards"
  CARD_SAMPLES.each do |card|
    CardChecker.new(card).call
  end
  
  puts "\n #{"*"*20}  Untidy Cards"
  UNTIDY_SAMPLES.each do |card|
    CardChecker.new(card).call
  end

  puts "\n #{"*"*20}  Example: Valid & Invalid"
  CardChecker.new(VALID_CARD).call
  CardChecker.new(INVALID_CARD).call

  # Tests features : sanitize, recognizer, validator
  
  def test_sanitize_feature
    assert_equal "6014355529000028", CardChecker.new("6014 !@3555--2900-0028").sanitized_numbers
  end

  def test_recognizer_feature
    assert_equal "Fly Buys Black", CardChecker.new(6014111100033006).recognize_card
    assert_equal "Fly Buys Red", CardChecker.new(6014352700000140).recognize_card
    assert_equal "Fly Buys Green", CardChecker.new(6014355526000020).recognize_card
    assert_equal "Fly Buys Blue", CardChecker.new(VALID_CARD).recognize_card
    assert_equal "Unknown", CardChecker.new(00).recognize_card
  end

  def test_validator_feature
    assert_equal "(valid)", CardChecker.new(VALID_CARD).validator
    assert_equal "(invalid)", CardChecker.new(INVALID_CARD).validator
  end
end