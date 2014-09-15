require "spec_helper"

RSpec.describe ReadActivity::Module do
  describe "#acts_as_reader" do
    it "should register self as klass of reader" do
      expect(ReadActivity::Reader.klass).to eq(User)
    end
  end

  describe "#acts_as_readable" do
    it "should register self as klass of readable" do
      expect(ReadActivity::Readable.klasses.include?(Article)).to eq(true)
    end
  end
end