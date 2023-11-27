# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find_by(id: params[:id])
    if @representative.nil?
      redirect_to representatives_path, alert: 'Representative not found'
    else
      render :show
    end
  end
end
