class V1::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]
  before_action :authenticate_v1_user!, only: [:create, :destroy, :update]


  def index
    questions = Question.includes(:answers,:user).page(params[:page] ||= 1).order('created_at DESC')
    total_pages = questions.total_pages
    crrent_pages = questions.current_page
    render json: questions, meta: {total_pages: total_pages, crrent_pages: crrent_pages}
  end

  def show
    serializable_resource = ActiveModelSerializers::SerializableResource.new(
    @question,
      includes: '**',
      each_serializer: QuestionSerializer,
      already_vote: current_v1_user.already_vote?(@question)
    )
    json = { question: serializable_resource.as_json }
    render json: json
    # render json: @question
  end

  def create
    question = current_v1_user.questions.new(question_params)
    answers = CreateAnswer.new(question).create_answers(params[:answers])

    if question.save
      render json: { status: 200 }
    else
      render json: {errors: question.errors}, status: :bad_request
    end
  end

  def update #TODO update will deprecate
    if @question.user_id == current_v1_user.id
      if @question.update(question_params)
        render json: @question
      else
        render json: {errors: @question.errors}
      end
    else
      render json: {errors: @question.errors}
    end

  end

  def destroy
    if @question.user_id == current_v1_user.id
      @question.destroy
      render json: @question
    else
      render json: {errors: @question.errors}
    end

  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.permit(:body)
  end

end
