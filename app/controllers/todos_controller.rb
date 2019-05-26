class TodosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @todos = current_user.todos.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @todo.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def todo_params
    params.require(:todo).permit(:content)
  end
  
  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
    unless @todo
      redirect_to root_url
    end
  end
end
