class ToppagesController < ApplicationController
  def index
    if logged_in?
      @todo = current_user.todos.build  # form_with 用
      @todos = current_user.todos.order(id: :desc).page(params[:page])
    end
  end
end
