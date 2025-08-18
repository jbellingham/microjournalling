class AchievementsController < ApplicationController
  before_action :set_achievement, only: [:show, :edit, :update, :destroy]

  def index
    @achievements = Achievement.all
    
    # Apply category filter
    if params[:category].present?
      @achievements = @achievements.where(category: params[:category])
    end
    
    # Apply date range filters
    if params[:date_from].present?
      @achievements = @achievements.where('date >= ?', params[:date_from])
    end
    
    if params[:date_to].present?
      @achievements = @achievements.where('date <= ?', params[:date_to])
    end
    
    @achievements = @achievements.order(date: :desc).page(params[:page]).per(20)
  end

  def show
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    
    if @achievement.save
      redirect_to @achievement, notice: 'Achievement was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @achievement.update(achievement_params)
      redirect_to @achievement, notice: 'Achievement was successfully updated.'
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
