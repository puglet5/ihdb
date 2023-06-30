# frozen_string_literal: true

class PostersController < ApplicationController
  before_action :set_poster, only: %i[show edit update destroy]

  breadcrumb 'Home', :root
  breadcrumb 'Posters', :posters, match: :exclusive

  def index
    posters = Poster.all.order('created_at asc')

    @query = posters.ransack(params[:query])
    @pagy, @posters = pagy @query.result(distinct: true).order('created_at DESC'), items: 20
  end

  def show
    @poster = Poster.find(params[:id])

    respond_to do |format|
      format.html do
        breadcrumb @poster.title, @poster, match: :exclusive
      end
    end
  end

  def new
    @poster = current_user.posters.build poster_params
    @poster.images.build

    breadcrumb 'New Poster', %i[new poster], match: :exclusive
  end

  def edit
    breadcrumb @poster.title, @poster, match: :exclusive
    breadcrumb 'Edit', [:edit, @poster], match: :exclusive
  end

  def create
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
