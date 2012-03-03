# Lime

Author:: Thomas Sawyer
License:: FreeBSD
Copyright:: (c) 2011 Thomas Sawyer, Rubyworks


## Description

Lime is pure-Ruby Gherkin-style test framework.


## Example

``` ruby
Feature "Addition" do
  To "avoid silly mistakes"
  As "a math idiot"
  We "need to calculate the sum of numbers"

  Scenario "Add two numbers" do
    Given "I have a calculator"
    Given "I have entered 50 into the calculator"
    Given "I have entered 70 into the calculator"
    When  "I press add"
    Then  "the result should be 120 on the screen"
  end

  Scenario "Add three numbers" do
    Given "I have a calculator"
    Given "I have entered 50 into the calculator"
    Given "I have entered 70 into the calculator"
    Given "I have entered 90 into the calculator"
    When  "I press add"
    Then  "the result should be 2101 on the screen"
  end

  Given 'I have a calculator' do
    require 'calculator'
    @calculator = Calculator.new
  end

  Given 'I have entered (((\d+))) into the calculator' do |n|
    @calculator.push n.to_i
  end

  When 'I press add' do
    @result = @calculator.add
  end

  Then 'the result should be (((\d+))) on the screen' do |n|
    @result.assert == n.to_i
  end
end
```


## Copyrights

Copyright (c) 2011 Rubyworks

Lime is distributed according to the terms of the *FreeBSD* license.

See COPYING.rdoc for details.

