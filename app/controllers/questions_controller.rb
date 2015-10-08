class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
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
  	  redirect_to @question, notice: "Yay, #{current_user.name}, question saved!"
  	else
  	  render 'new', notice: "Oh no, #{current_user.name}, Question couldn't be saved!"
 	end
  end

  def show
  end

  def update
  	if @question.update(question_params)
  	  redirect_to @question, notice: "Yay, the question has been updated!"
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
