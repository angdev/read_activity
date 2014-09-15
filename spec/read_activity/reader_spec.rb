require "spec_helper"

RSpec.describe ReadActivity::Reader do
  describe ".find_who_read" do
    it "should find users who read a readable" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      read_users = User.find_who_read(article)
      expect(read_users.empty?).to eq(true)

      user.read!(article)
      read_users = User.find_who_read(article)
      expect(read_users.include?(user)).to eq(true)
    end
  end

  describe ".find_who_unread" do
    it "should find users who unread a readable" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      unread_users = User.find_who_unread(article)
      expect(unread_users.include?(user)).to eq(true)

      user.read!(article)
      unread_users = User.find_who_unread(article)
      expect(unread_users.empty?).to eq(true)
    end
  end

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

  describe "#readables_unmarked_as_read" do
    it "should return readables unread by reader" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(user.readables_unmarked_as_read(Article).include?(article)).to eq(true)

      user.read!(article)
      expect(user.readables_unmarked_as_read(Article).empty?).to eq(true)
    end
  end

  describe "#unread_(.*)" do
    it "should be call correctly for readables" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)

      expect(user.unread_articles.include?(article)).to eq(true)

      user.read!(article)
      expect(user.unread_articles.empty?).to eq(true)
    end

    it "should fail for unknown readables" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)
      expect(user.unread_articles.empty?).to eq(false)
      expect { user.unread_posts }.to raise_error
    end
  end
end