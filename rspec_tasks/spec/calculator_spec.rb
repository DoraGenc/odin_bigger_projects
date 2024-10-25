require './lib/calculator'
   
describe Calculator do
  describe "#add" do

    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7.0)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14.0)
    end
  end 


  describe "#multiply" do

    it "returns the product of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 2)).to eql(4.0)
    end

    it "returns the product of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3, 4)).to eql(24.0)
    end

    it "doesn't accept less than 1 number" do
      calculator = Calculator.new
      expect(calculator.multiply(1.0)).to  eql("Please type in more than one number.")
    end
  end


  describe "#substract" do 

    it "returns the difference of two numbers" do
      calculator = Calculator.new
      expect(calculator.substract(3, 1)).to eql(2.0)
    end

    it "can return negative numbers" do
      calculator = Calculator.new
      expect(calculator.substract(1, 4)).to eql(-3.0)
    end

    it "doesn't accept less than 1 number" do
      calculator = Calculator.new
      expect(calculator.substract(1)).to eql("Please type in more than one number.")
    end
  end

  
  describe "#divide" do

    it "returns the quotient of two numbers" do
      calculator = Calculator.new
      expect(calculator.divide(4, 2)).to eql(2.0)
    end

    it "can return decimal numbers" do
      calculator = Calculator.new
      expect(calculator.divide(1, 2)).to eql(0.5)
    end

    it "doesn't accept less than 1 number" do
      calculator = Calculator.new
      expect(calculator.divide(1)).to eql("Please type in more than one number.")
    end
  end
end