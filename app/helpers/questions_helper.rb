module QuestionsHelper
  def answered_by_current_user?
  	@question = Question.find(params[:id])
  	@question.answers.where(user_id: current_user.id).any? 
  end

  def own_question?
    @question = Question.find(params[:id])
    @question.user_id == current_user.id
  end

  def own_answer_content
  	@question = Question.find(params[:id])
  	@question.answers.find_by(user_id: current_user.id).content
  end

  def own_answer
  	@question = Question.find(params[:id])
  	@question.answers.find_by(user_id: current_user.id)
  end
end
