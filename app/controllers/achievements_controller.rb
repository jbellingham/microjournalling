class AchievementsController < ApplicationController
  before_action :set_achievement, only: [:show, :edit, :update, :destroy]

  def index
    @achievements = Achievement.order(date: :desc)
  end

  def show
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    
    if @achievement.save
      respond_to do |format|
        format.html { redirect_to @achievement, notice: 'Achievement was successfully created.' }
        format.turbo_stream { redirect_to @achievement, notice: 'Achievement was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @achievement.update(achievement_params)
      respond_to do |format|
        format.html { redirect_to @achievement, notice: 'Achievement was successfully updated.' }
        format.turbo_stream { redirect_to @achievement, notice: 'Achievement was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_url, notice: 'Achievement was successfully deleted.'
  end

  private

  def set_achievement
    @achievement = Achievement.find(params[:id])
  end

  def achievement_params
    params.require(:achievement).permit(:title, :description, :date, :category)
  end
end
