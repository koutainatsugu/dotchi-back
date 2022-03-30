require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "body" do
    context "blankの時に" do
      it 'invalidになる' do
        question = create(:question, body: "anserのテスト")
        answer = question.answers.build(body: "", question: question)
        expect(answer).not_to be_valid
      end
    end
    context "maxlengthで" do
      context "１５文字以内で" do
        it 'validになる' do
          question = create(:question, body: "anserのテスト")
          answer = question.answers.build(body: "a"*15, question: question)
          expect(answer).to be_valid
        end
      end
      context "１６文字以上で" do
        it 'invalidになる' do
          question = create(:question, body: "anserのテスト")
          answer = question.answers.build(body: "a"*16, question: question)
          expect(answer).not_to be_valid
        end
      end
    end
  end
end
