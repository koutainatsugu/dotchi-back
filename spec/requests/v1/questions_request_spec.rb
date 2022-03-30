require 'rails_helper'

RSpec.describe "V1::Questions", type: :request do
  describe "GET /v1/questions#index" do
    before do
      FactoryBot.create_list(:question, 3) do |q|
        FactoryBot.create_list(:answer, 3, question: q)
      end
    end
    it '正常レスポンスが帰ってくる' do
      get v1_questions_url
      expect(response.status).to eq 200
    end
    it "件数が正しく返ってくる" do
      get v1_questions_url
      json = JSON.parse(response.body)
      expect(json["questions"].length).to eq(3)
    end
    it "id降順にレスポンスが返ってくる" do
      get v1_questions_url
      json = JSON.parse(response.body)
      first_id = json["questions"][0]["id"]
      expect(json["questions"][1]["id"]).to eq(first_id - 1)
      expect(json["questions"][2]["id"]).to eq(first_id - 2)
    end
    it 'questionが指定数のanswerを持っている' do
      get v1_questions_url
      json = JSON.parse(response.body)
      expect(json["questions"][0]["answers"].length).to eq 3
    end
  end

  describe "GET /v1/questions#show" do
    let(:question) do
      create(:question, body: "showのテスト")
    end
    it '正常レスポンスが帰ってくる' do
      get v1_question_url({id: question.id})
      expect(response.status).to eq 200
    end
    it 'bodyが正しく返ってくる' do
      get v1_question_url({id: question.id})
      json = JSON.parse(response.body)
      expect(json["question"]["body"]).to eq("showのテスト")
    end
    it '存在しないidの時404エラーになる' do
      get v1_question_url({id: question.id + 1})
      expect(response.status).to eq 404
    end
  end

  describe "GET /v1/questions#create" do
    let(:new_question) do
      attributes_for(:question, body: "create_bodyのテスト", answers: ["answer1", "answer2", "answer3"])
    end

    it '正常なレスポンスが返る' do
      post v1_questions_url, params: new_question
      expect(response.status).to eq 200
    end
    it '１件増えて返ってくる' do
      expect do
        post v1_questions_url, params: new_question
      end.to change { Question.count }.by(1)
    end
    it 'bodyが返る' do
      post v1_questions_url, params: new_question
      json = JSON.parse(response.body)
      expect(json["question"]["body"]).to eq("create_bodyのテスト")
      expect(json["question"]["answers"][0]["body"]).to eq("answer1")
    end
    it '不正パラメータでエラー' do
      post v1_questions_url, params: {}
      json = JSON.parse(response.body)
      expect(json.key?("errors")).to be true
    end
    it 'answerが４つ以上で異常なレスポンスを返す' do
      invalid_question = attributes_for(:question, body: "create_bodyのテスト", answers: ["answer1", "answer2", "answer3","answer4", "answer5", "answer6"])
      post v1_questions_url, params: invalid_question
      json = JSON.parse(response.body)
      expect(json.key?("errors")).to be true
    end
  end

  describe "GET /v1/questions#update" do
    let(:update_param) do
      question = create(:question)
      update_param = attributes_for(:question, body: "updateのテスト")
      update_param[:id] = question.id
      update_param
    end
    it '正常なレスポンス' do
      put v1_question_url({id: update_param[:id]}), params: update_param
      expect(response.status).to eq 200
    end
    it '正常なbodyが返ってくる' do
      put v1_question_url({id: update_param[:id]}), params: update_param
      json = JSON.parse(response.body)
      expect(json["question"]["body"]).to eq("updateのテスト")
    end
    it '不正なパラメータでerrorになる' do
      put v1_question_url({id: update_param[:id]}), params: {body: ""}
      json = JSON.parse(response.body)
      expect(json.key?("errors")).to be true
    end
    it '存在しないidで404エラー' do
      put v1_question_url({id: update_param[:id] + 1 }), params: update_param
      expect(response.status).to eq 404
    end
  end
end
