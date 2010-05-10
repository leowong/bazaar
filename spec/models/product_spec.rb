require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  it "should be valid" do
    Product.new.should be_valid
  end
end
