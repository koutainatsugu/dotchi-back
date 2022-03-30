class CreateAnswer
  def initialize(question)
    @question = question
  end

  def create_answers(answers)
    if answers
      questions_answers = answers.reject(&:empty?)
      questions_answers.each do |ans|
        answer = @question.answers.build(body: ans )
      end
    end
  end
end