class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :votes_count
  belongs_to :question
end
