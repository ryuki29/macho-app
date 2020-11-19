class RecordsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_post, only: [:edit, :show]

  def index
    @records = Record.includes(:user).order("created_at DESC")
  end

  def new
    @record = Record.new
  end

  def create
    Record.create(record_params)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def search
    @records = Record.search(params[:keyword])
  end

  def edit
  end

  def update
    record = Record.find(params[:id])
    record.update(record_params)
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
  end

  private
  def record_params
    params.require(:record).permit(:text).merge(user_id: current_user.id)
  end

  def set_record
    @record = Record.find(para,s[:id])
  end
end
