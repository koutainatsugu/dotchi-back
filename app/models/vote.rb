class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer, counter_cache: :votes_count
  belongs_to :question
  validates :user_id, uniqueness: { scope: :question_id}
end
