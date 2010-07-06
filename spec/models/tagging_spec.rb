require File.dirname(__FILE__) + '/../spec_helper'

describe Tagging do
  it "should be valid" do
    Tagging.new.should be_valid
  end
end
