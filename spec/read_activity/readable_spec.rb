require "spec_helper"

RSpec.describe ReadActivity::Readable do
  describe ".find_read_by" do
    it "find all readables read by user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      read_articles = Article.find_read_by(user)
      expect(read_articles.empty?).to eq(true)

      article.read_by!(user)
      read_articles = Article.find_read_by(user)
      expect(read_articles.include?(article)).to eq(true)
    end
  end

  describe "#read_by!" do
    it "should create a ReadActivityMark for an unread user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)
      article.read_by!(user)

      mark = article.read_activity_marks.first
      expect(mark.reader).to eq(user)
      expect(mark.readable).to eq(article)
    end
  end

  describe "#read_by?" do
    it "should return whether a readable is read by user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(article.read_by?(user)).to eq(false)

      article.read_by!(user)
      expect(article.read_by?(user)).to eq(true)
    end
  end

  describe "#readers" do
    it "should return readers who read a readable" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(article.readers.empty?).to eq(true)

      article.read_by!(user)
      expect(article.readers.include?(user)).to eq(true)
    end
  end
end