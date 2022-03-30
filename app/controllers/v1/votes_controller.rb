class V1::VotesController < ApplicationController
  before_action :authenticate_v1_user!, only: [:create]
  def create
    @answer = Answer.find(params[:id])
    @answer.votes.build(user: current_v1_user, question: @answer.question)
    if @answer.save
      render json: {status: 200}
    else
      render json: {errors: @answer.errors}, status: :bad_request
    end
  end
end
