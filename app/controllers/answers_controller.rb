class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :update, :edit, :destroy]

  def create
    @questioner = @question.user
    @answer = @question.answers.build(answer_params)
    @answer.user_id = current_user.id

    # Create a friendship only if they are not friends already
    @friendship = current_user.friendships.build(friend_id: @questioner.id, approved: "false") unless current_user.friends_with?(@questioner)

  	if @answer.save && (@friendship.save == true if @friendship != nil)
      redirect_to question_path(@question), notice: "Antwort wurde gespeichert, yay!"
  	else
      @messages = []
      @answer.errors.full_messages.each do |msg|
        @messages << msg
      end
      redirect_to question_path(@question), alert: "Die Antwort konnte leider nicht gespeichert werden: #{@messages}"
  	end
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: "Yay, Antwort wurde gespeichert!"
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


=begin
  def create
    @answer = @question.answers.build(answer_params)
    @friendship = current_user.friendships.build(friend_id: @question.user.id, approved: "false")
    @answer.user_id = current_user.id

    if @answer.save && @friendship.save
      redirect_to question_path(@question), notice: "Antwort wurde gespeichert, yay!"
    else
      @messages = []
      @answer.errors.full_messages.each do |msg|
        @messages << msg
      end
      redirect_to question_path(@question), alert: "Die Antwort konnte leider nicht gespeichert werden: #{@messages}"
    end
  end
=end