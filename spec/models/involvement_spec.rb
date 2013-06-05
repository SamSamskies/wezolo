require 'spec_helper'

describe Involvement do
  it "must have a country" do
    pending
  end

  it "update auth status after the first create" do
    pending
  end

  it "start date must be before end date" do
    build(:involvement, start_date: Time.now).should be_invalid
  end

  it "downcases sector before validation" do
    build(:involvement, sector: "ICT").should be_valid
  end
end
