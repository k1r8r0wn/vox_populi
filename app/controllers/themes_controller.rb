class ThemesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :autocomplete]
  before_action :set_category, except: [:new_separate, :create_separate]
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  helper_method :current_city

  def index
    if params[:query].present?
      @themes = Theme.search params[:query], page: params[:page]
    else
      @themes = Theme.where(category_id: params[:category_id])
      @themes = @themes.page(params[:page]).per(10)
    end
  end

  def new
    @theme = @category.themes.new
    authorize @theme
  end

  def new_separate
    @theme = Theme.new
    @categories = Category.all
    authorize @theme
  end

  def show
    @root_comments = @theme.comments.root_comments
  end

  def edit; end

  def create
    authorize Theme
    @theme = @category.themes.new(theme_params)
    @theme.user_id = current_user.id

    if @theme.save
      redirect_to category_theme_path(@category, @theme), success: t('.success', theme: @theme.title)
    else
      flash.now[:error] = t('.error')
      render :new
    end
  end

  def create_separate
    @theme = current_user.themes.new(theme_params)
    authorize @theme
    if @theme.save
      redirect_to category_theme_path(@theme.category, @theme), success: t('.success', theme: @theme.title)
    else
      flash.now[:error] = t('.error')
      render :new_separate
    end
  end

  def update
    authorize @theme
    if @theme.update_attributes(theme_params)
      redirect_to category_theme_path(@category, @theme), success: t('.success', theme: @theme.title)
    else
      flash.now[:error] = t('.error')
      render :edit
    end
  end

  def destroy
    authorize @theme
    if @theme.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to category_themes_path
  end

  def vote_for
    current_user.vote_for(set_theme)
    voted?
  end

  def vote_against
    current_user.vote_against(set_theme)
    voted?
  end

  def revote
    current_user.unvote_for(set_theme)
    authorize @theme
    redirect_to :back, success: t('.success')
  end

  def current_city
    @city ||= get_current_city
  end

  def autocomplete
    render json: Theme.search(
      params[:term],
      fields: [{ title: :word_start }],
      where: { category_id: params[:category_id] }
    ).map(&:title)
  end

  private

  def set_theme
    @theme = @category.themes.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def theme_params
    params.require(:theme).permit(:title, :content, :category_id, :city_id)
  end

  def voted?
    authorize @theme
    if @theme.voted_by?(current_user)
      redirect_to :back, success: t('.success')
    else
      redirect_to :back, error: t('.error')
    end
  end

  def get_current_city
    return City.find_by(id: session[:city_id]) if session[:city_id].present?

    city = City.find_by_ip(request.remote_ip)
    session[:city_id] = city.try(:id) if city

    city
  end

end
