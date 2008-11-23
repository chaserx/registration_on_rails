require File.join(File.dirname(__FILE__), 'brain_buster_test_helper')

describe "BrainBuster model object" do
  include BrainBusterTestHelper
  
  it "should answer simple math ignoring spacing" do
    two_plus_two.attempt?("4").should.be true
    two_plus_two.attempt?(" 4   ").should.be true
    two_plus_two.attempt?("3").should.be false
  end
  
  it "should be able to use words to answer numerical questions" do 
    ["four", "   four   ", " FoUr ", "  fouR"].each do |answer|
      two_plus_two.attempt?(answer).should.be true
    end
  end
  
  it "should handle zeroes" do
    ["0", "zero ", "  zerO  "].each do |answer|
      ten_minus_ten.attempt?(answer).should.blaming(answer).be(true)
    end
  end
  
  it "should handle string answers ignoring spacing and case" do
    %w[monday MonDay MONDAY MonDay].push("   MondaY  ").each do |answer|
      day_before_tuesday.attempt?(answer).should.blaming(answer).be(true)
    end
  end
  
  it "should ignore case in the answer" do
    stub_brain_buster(:question => "Spell god backwards", :answer => "Dog").attempt?("dog").should == true
    stub_brain_buster(:question => "Spell god backwards", :answer => "Dog").attempt?("DOG").should == true
  end

  # fixtures
  def ten_minus_ten
    stub_brain_buster(:question => "What is ten minus ten?", :answer => "0")
  end
  
  def two_plus_two
    stub_brain_buster(:question => "What is two plus two?", :answer => "4")
  end
  
  def day_before_tuesday
    stub_brain_buster(:question => "What is the day before Tuesday?", :answer => "monday")
  end
  
end
