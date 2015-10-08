class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(params[:answer].permit(:content))
    @answer.user_id = current_user.id

  	if @answer.save
  	  flash[:notice] = "Answer successfully saved!"
      redirect_to question_path(@question)
  	else
  	  flash[:notice] = "Could not create answer: #{@answer.errors}"
      redirect_to question_path(@question)
  	end
  end

  def destroy
    @question = Question.find(params[:question_id])
  	@answer = @question.answers.find(params[:id])
  	@answer.destroy

  	redirect_to question_path(@question)
  end
end
