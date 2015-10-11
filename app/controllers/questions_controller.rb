class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :find_question, only: [:show, :edit, :update, :destroy]


  def index
    @questions = Question.order("created_at DESC").all
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = current_user.questions.build(question_params)

  	if @question.save
  	  redirect_to @question, notice: "Yay, #{current_user.name}, die Frage wurde gespeichert!"
  	else
  	  render 'new', notice: "Oh nein, #{current_user.name}, die Frage konnte nicht gespeichert werden."
 	end
  end

  def show
  end

  def update
  	if @question.update(question_params)
  	  redirect_to @question, notice: "Yay, die Frage wurde auf den neuesten Stand gebracht!"
  	else 
  	  render 'edit'
  	end
  end

  def destroy
  	@question.destroy
  	redirect_to user_path(current_user)
  end

  private
    def question_params
      params.require(:question).permit(:question)
    end

    def find_question
      @question = Question.find(params[:id])
    end
end
