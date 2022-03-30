class Question < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: {maximum: 50}
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  validate :answer_number_validation
  #TODO
  # Answerの最低個数と最大の個数のバリデーションが必要

  def answer_number_validation
    if answers.length > 4 or answers.length < 2
      errors.add(:body)
    end
  end
end
