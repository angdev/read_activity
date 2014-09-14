require "spec_helper"

RSpec.describe ReadActivity::Reader do
  describe "#read_as_mark!" do
    it "should create a ReadActivityMark for an unread user" do
      user = FactoryGirl.create(:user)
      article = FactoryGirl.create(:article)
      user.read_as_mark!(article)

      mark = user.read_activity_marks.first
      expect(mark.reader).to eq(user)
      expect(mark.readable).to eq(article)
    end
  end
end