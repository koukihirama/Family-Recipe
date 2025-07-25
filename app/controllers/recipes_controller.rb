class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def new
    @recipe = Recipe.new
    @recipes = current_family.recipes.order(created_at: :desc)
  end

  def index
    @recipes = Recipe.includes(:tags, image_attachment: :blob)
                     .where(family_id: current_family.id)
                     .order(created_at: :desc)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.family = current_family

    if @recipe.save
      redirect_to recipes_path, notice: "投稿できました"
    else
      @recipes = current_family.recipes.order(created_at: :desc)
      render :new
    end
  end

  def show
    redirect_to recipes_path, alert: "アクセスできません" unless @recipe.family_id == current_family.id
  end

  def edit
    @tag_names = @recipe.tags.pluck(:name).join(",")
  end

  def update
    tag_names = params[:recipe].delete(:tag_names)

    ActiveRecord::Base.transaction do
      if @recipe.update!(recipe_params)
        @recipe.tags = tag_names.to_s.split(",").map(&:strip).uniq.reject(&:blank?).map do |tag_name|
          Tag.find_or_create_by!(name: tag_name)
        end
      end
    end

    redirect_to @recipe, notice: "レシピを更新しました。"
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "レシピを削除しました。"
  end

  def public_view
  @recipe = Recipe.find(params[:id])
  unless @recipe.published?
    redirect_to root_path, alert: "このレシピは公開されていません"
    return
  end

  @family = @recipe.family
  # @member は表示しない or 匿名表示（ビュー側で対応）
end


  def public_index
    @recipes = Recipe.where(published: true).order(created_at: :desc).includes(:member, :family)
  end

  private

  def recipe_params
  params.require(:recipe).permit(
    :title, :ingredients, :instructions,
    :required_time, :difficulty, :image,
    :tag_names, :member_id, :published # ← is_public ではなく published
  )
end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_user!
    redirect_to recipes_path, alert: "権限がありません" unless @recipe.family == current_family
  end
end
