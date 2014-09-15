require "spec_helper"

RSpec.describe ReadActivity::Reader do
  describe "#read!" do
    it "should create a ReadActivityMark for an unread user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)
      user.read!(article)

      mark = user.read_activity_marks.first
      expect(mark.reader).to eq(user)
      expect(mark.readable).to eq(article)
    end
  end

  describe "#read?" do
    it "should return whether a readable is read by user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(user.read?(article)).to eq(false)

      user.read!(article)
      expect(user.read?(article)).to eq(true)
    end
  end

  describe "#readables_marked_as_read" do
    it "should return readables read by reader" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(user.readables_marked_as_read(Article).empty?).to eq(true)

      user.read!(article)
      expect(user.readables_marked_as_read(Article).include?(article)).to eq(true)
    end
  end

  describe "#read_(.*)" do
    it "should be call correctly for readables" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(user.read_articles.empty?).to eq(true)

      user.read!(article)
      expect(user.read_articles.include?(article)).to eq(true)
    end

    it "should fail for unknown readables" do
      user = FactoryGirl.create(:user)
      expect(user.read_articles.empty?).to eq(true)
      expect { user.read_posts }.to raise_error
    end
  end
end