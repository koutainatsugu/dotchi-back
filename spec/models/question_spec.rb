require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "body" do
    context "blankの時に" do
      it "invalidになる" do
        question = build(:question, body: "")
        expect(question).not_to be_valid
      end
    end
    context "maxlengthで" do
      context "30文字以内で" do
        it "validになる" do
          question =  build(:question, body: "a"*30)
          expect(question).to be_valid
        end
      end
      context "31文字以上で" do
        it "invalidになる" do
          question =  build(:question, body: "a"*31)
          expect(question).not_to be_valid
        end
      end
    end
  end
end
