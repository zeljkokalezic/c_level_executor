require 'spec_helper'

describe CExecutor do
  describe "execute" do
    it "executes C factorial function" do

      function = <<FUNCTION
      long factorial(int max) {
        int i=max, result=1;
        while (i >= 2) { result *= i--; }
        return result;
      }
FUNCTION

      executor = CExecutor.new(function)

      expect(executor.execute('factorial', 5)).to eq 120
    end

    it "executes C return input function" do

      function = <<FUNCTION
      int solution(int n) {
        return n;
      }
FUNCTION

      executor = CExecutor.new(function)
      value = 55
      expect(executor.execute('solution', value)).to eq value
    end

    it "executes C return addition function with printf" do

      function = <<FUNCTION
      int solution_printf(int n, int m) {
        printf("this is a debug message");
        return n + m;
      }
FUNCTION

      executor = CExecutor.new(function)
      value = 55
      expect(executor.execute('solution_printf', "#{value}, #{value}")).to eq value*2
    end

    it "executes C return string function" do

      function = <<FUNCTION
      char *returnString() {
        char *mystr = "Hello World!";
        return mystr;
      }
FUNCTION

      executor = CExecutor.new(function)
      expect(executor.execute('returnString', nil)).to eq "Hello World!"
    end

    it "throws exception when arguments are invalid" do

      function = <<FUNCTION
      char *someFunction() {
        char *mystr = "Hello World!";
        return mystr;
      }
FUNCTION

      executor = CExecutor.new(function)

      expect { executor.execute('someFunction', 55) }.to raise_exception(ArgumentError)
    end

    it "throws exception when c code is invalid" do

      function = <<FUNCTION
      GARBAGE CODE
FUNCTION

      executor = CExecutor.new(function)

      expect { executor.execute('someFunction', 55) }.to raise_exception(SyntaxError)
    end

    it "throws exception when c calling function name is invalid" do

      function = <<FUNCTION
      int someIntFunction() {
        return 5;
      }
FUNCTION

      executor = CExecutor.new(function)

      expect { executor.execute('someFunction', nil) }.to raise_exception(NoMethodError)
    end

    it "passes string to c function and returns it" do

      function = <<FUNCTION
      char *someCharFunction(char *input) {
        return input;
      }
FUNCTION

      executor = CExecutor.new(function)

      expect(executor.execute('someCharFunction', '"Test"')).to eq "Test"
    end

    it "passes string and int to c function and returns string" do

      function = <<FUNCTION
      char *someCombinedFunction(char *input, int n) {
        return input;
      }
FUNCTION

      executor = CExecutor.new(function)

      expect(executor.execute('someCombinedFunction', '"Test", 30')).to eq "Test"
    end

  end
end
