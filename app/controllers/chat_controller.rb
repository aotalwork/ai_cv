class ChatController < ApplicationController
  def index
    @profile = Profile.includes(
      :experiences,
      :skills,
      :certifications,
      :educations,
      :languages,
      :achievements,
      :recommendations
    ).first
  end

  def ask
    question = params[:question].to_s.strip

    if question.blank?
      render json: { error: "Escribe una pregunta." }, status: :unprocessable_entity
      return
    end

    answer = AiCv::AnswerQuestion.call(question)

    render json: {
      question: question,
      answer: answer
    }
  end
end