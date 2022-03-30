class Answer < ApplicationRecord
  belongs_to :question
  has_many :votes, dependent: :destroy
  validates :body, presence: true
  validates :body, length: {maximum: 25}
  #TODO
  # presenceの設定をしているけど空文字の時は削除する処理が入っている
end
