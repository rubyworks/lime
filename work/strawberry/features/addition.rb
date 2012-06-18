Feature "Addition" do
  So "to avoid silly mistakes"
  As "a math idiot"
  Be "told the sum of two numbers"

  Scenario "Add two numbers" do
    Given "I have a calculator"
    Given "I have entered 50 into the calculator"
    Given "I have entered 70 into the calculator"
    When  "I press add"
    Then  "the result should be 120 on the screen"
  end

  Given 'I have a calculator' do
    @calculator = Calculator.new
  end

  Given 'I have entered /\d+/ into the calculator' do |n|
    @calculator.push n.to_i
  end

  When 'I press add' do
    @result = calculator.add
  end

  Then 'the result should be /\d+/ on the screen' do |n|
    @result == n.to_i
  end
end

