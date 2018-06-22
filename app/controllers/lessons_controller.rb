class LessonsController < ApplicationController
	before_action :authenticate_user!, only: :show
	before_action :current_user_enrolled?

	def show
	end

	private

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

	def current_user_enrolled?
		if current_user && current_user.enrolled_in?(current_lesson.section.course) == false
			redirect_to course_path(current_lesson.section.course), notice: 'You must be enrolled to view lessons'
		end
	end
end
