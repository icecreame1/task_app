class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all.order(:start_day)
  end
  
  def new
    @schedule = Schedule.new
  end
  
  def create
    @schedule = Schedule.new(params.require(:schedule).permit(:title, :start_day, :end_day, :all_day, :memo))
    if @schedule.save
      flash[:notice] = "スケジュールを新規登録しました"
      redirect_to schedules_path
    else
      flash[:notice] = "スケジュールの登録が出来ませんでした"
      render "new"
    end
  end
  
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
  end
  
  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(params.require(:schedule).permit(:title, :start_day, :end_day, :all_day, :memo))
      flash[:notice] = "IDが「#{@schedule.id}」のスケジュールを更新しました"
      redirect_to schedules_path
    else
      flash[:notice] = "スケジュールの更新が出来ませんでした"
      render "edit"
    end
  end
  
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to schedules_path
  end
  
  def current
    @current = Date.current.strftime("%Y年 %m月 %d日")
  end

  before_action :current, oniy: [:index, :new, :show, :edit]
end