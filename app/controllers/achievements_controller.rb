class AchievementsController < ApplicationController
  before_action :set_achievement, only: [:show, :edit, :update, :destroy, :toggle_favorite]

  def index
    @achievements = current_user.achievements
    
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

  def weekly
    # Get the week parameter or default to current week
    if params[:week].present?
      date = Date.parse(params[:week])
    else
      date = Date.current
    end
    
    @current_week = date.beginning_of_week
    @week_end = @current_week.end_of_week
    
    @achievements = current_user.achievements.where(date: @current_week..@week_end).order(date: :desc)
    @achievements_by_category = @achievements.group_by(&:category)
    @achievements_by_day = @achievements.group_by(&:date)
    
    @prev_week = @current_week - 1.week
    @next_week = @current_week + 1.week
  end

  def monthly
    # Get the month parameter or default to current month
    if params[:month].present?
      date = Date.parse(params[:month])
    else
      date = Date.current
    end
    
    @current_month = date.beginning_of_month
    @month_end = @current_month.end_of_month
    
    @achievements = current_user.achievements.where(date: @current_month..@month_end).order(date: :desc)
    @achievements_by_category = @achievements.group_by(&:category)
    @achievements_by_week = group_achievements_by_week(@achievements)
    
    @prev_month = @current_month - 1.month
    @next_month = @current_month + 1.month
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = current_user.achievements.build(achievement_params)
    
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

  def toggle_favorite
    @achievement.update!(favorite: !@achievement.favorite)
    
    respond_to do |format|
      format.html { redirect_back_or_to achievement_path(@achievement) }
      format.turbo_stream { 
        # Update both button types that might be present
        render turbo_stream: [
          turbo_stream.replace("favorite_button_#{@achievement.id}", partial: "achievements/favorite_button", locals: { achievement: @achievement }),
          turbo_stream.replace("favorite_button_large_#{@achievement.id}", partial: "achievements/favorite_button_large", locals: { achievement: @achievement })
        ]
      }
    end
  end

  private

  def set_achievement
    @achievement = current_user.achievements.find(params[:id])
  end

  def achievement_params
    params.require(:achievement).permit(:title, :description, :date, :category, 
                                      :impact_metrics, :collaboration_details, 
                                      :learning_outcomes, :goals_supported)
  end

  def group_achievements_by_week(achievements)
    achievements.group_by { |achievement| achievement.date&.beginning_of_week }
  end
end
