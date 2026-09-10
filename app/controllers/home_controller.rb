class HomeController < ApplicationController
  def index
    @profile = Profile.first

    @experiences = @profile.experiences.order(start_date: :desc)
    @skills = @profile.skills.order(:category, :name)
    @certifications = @profile.certifications.order(year: :desc)
    @educations = @profile.educations.order(start_year: :desc)
    @languages = @profile.languages.order(:name)
    @achievements = @profile.achievements.order(:position)
    @recommendations = @profile.recommendations.order(date: :desc)
  end
end