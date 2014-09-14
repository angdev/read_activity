require "spec_helper"

RSpec.describe ReadActivity::Readable do
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
end