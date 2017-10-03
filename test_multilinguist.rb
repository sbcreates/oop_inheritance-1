require 'minitest/autorun'
require 'minitest/pride'
require './multilinguist_2.rb'

class TestMultilinguist < MiniTest::Test

  def set_up
    Multilinguist.new
  end
# Write a unit test for the language_in method.
  def test_language_in_countries
    sarah = set_up
    outcome_one = sarah.language_in('japan')
    outcome_two = sarah.language_in('china')
    outcome_three = sarah.language_in('iceland')
    outcome_four = sarah.language_in('korea')
    assert_equal(outcome_one, 'ja')
    assert_equal(outcome_two, 'zh')
    assert_equal(outcome_three, 'is')
    assert_equal(outcome_four, 'ko')

  end

end
