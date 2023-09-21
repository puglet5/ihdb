# frozen_string_literal: true

class PostersController < ApplicationController
  before_action :set_poster, only: %i[edit update destroy]

  breadcrumb 'home', :root, match: :exclusive
  breadcrumb 'posters.posters', :posters, match: :exclusive

  def index
    posters = Poster.order('created_at asc')

    authorize posters

    @query = posters.ransack(params[:query])
    @pagy, @posters = pagy @query.result(distinct: true).order('created_at DESC'), items: 20
  end

  def show
    @poster = Poster.find(params[:id])

    authorize @poster

    respond_to do |format|
      format.html do
        breadcrumb @poster.title, @poster, match: :exclusive
      end
    end
  end

  def new
    authorize Poster

    @poster = current_user.posters.build poster_params
    @poster.images.build

    breadcrumb 'posters.new', %i[new poster], match: :exclusive
  end

  def edit
    authorize @poster

    breadcrumb @poster.title, @poster, match: :exclusive
    breadcrumb 'posters.edit', [:edit, @poster], match: :exclusive
  end

  def create
    authorize Poster

    @poster = current_user.posters.build(poster_params)

    if @poster.save
      redirect_to @poster
      flash[:success] = 'Poster added!'
    else
      @poster.images.build
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @poster

    if @poster.update poster_params
      redirect_to @poster
      flash[:success] = 'Poster updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    flash[:error] = 'Error! Poster was modified elsewhere.'
    redirect_to [:edit, @poster]
  end

  def destroy
    authorize @poster

    @poster.destroy
    flash[:success] = 'Poster deleted!'
    redirect_to posters_url, status: :see_other
  end

  private

  def set_poster
    @poster = Poster.find(params[:id])
  end

  def poster_params
    params.fetch(:poster, {}).permit(
      :title,
      :description,
      images_attributes: %i[id image]
    )
  end
end
