class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :show_result

  has_many :answers
  belongs_to :user

  def show_result
    already_vote = @instance_options[:already_vote]
    if already_vote === true
      true
    else
      false
    end
  end

end
