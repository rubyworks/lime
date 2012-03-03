# Lime

[Website](http://rubyworks.github.com/lime) /
[Source Code](http://github.com/rubyworks/lime) /
[Report Issue](http://github.com/rubyworks/lime/issues) /
[Mailing List](http://groups.google.com/groups/rubyworks-mailinglist)


## Description

Lime is pure-Ruby Gherkin-style test framework.


## Instruction

Lime lets you write features scripts using Ruby, yet still do
so with a close approximation to Gherkin domain language.

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

The last set of `Given` and `When` procedures are called the *advice definitions*. These
can be placed in their own modules and included into the Feature scope like any other module.
They simply need to include the `Lime::Featurette` module to do so. For instance:

```ruby
module CalculatorAdvice
  include Lime::Featurette

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

If you add such scripts to a subdirectory called `featurettes` relative to the
feature that uses them, then they will be loaded automatically when features
are run.

Speaking of which, to run features use the `rubytest` command line tool.

```
$ rubytest -Ilib spec/feature_addition.rb
```

See [RubyTest](http://rubyworks.github.com/rubytest) to learn more.


## Copyrights

Copyright (c) 2011 Rubyworks

Lime is distributed according to the terms of the *FreeBSD* license.

See LICENSE.txt for details.
