class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :update, :edit, :destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id

  	if @answer.save
      redirect_to question_path(@question), notice: "Answer successfully saved!"
  	else
      @messages = []
      @answer.errors.full_messages.each do |msg|
        @messages << msg
      end
      redirect_to question_path(@question), alert: "Could not create answer: #{@messages}"
  	end
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: "Yay, Answer updated!"
    else
      render edit_question_answer_path(@answer.question, @answer) 
    end
  end

  def destroy
  	@answer = @question.answers.find(params[:id])
  	@answer.destroy

  	redirect_to question_path(@question)
  end

  private

    def find_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
end
