# frozen_string_literal: true

class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    puts "Rating params: #{rating_params}"  # Debugging statement

    @rating.user_id = session[:current_user_id] # Assign the user ID from the session

    if @rating.save
      update_news_item_average_rating(@rating.news_item)
      redirect_to representative_news_item_path(@rating.news_item.representative, @rating.news_item),
                  notice: 'Rating was successfully created.'
    else
      flash[:alert] = @rating.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :news_item_id, :user_id)
  end

  def update_news_item_average_rating(news_item)
    average_rating = news_item.ratings.average(:rating).to_f
    news_item.update(average_rating: average_rating)
  end
end
