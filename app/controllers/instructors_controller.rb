class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        instructors = Instructor.all 
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {error: "validation failed"}, status: :unprocessable_entity
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error: "Instructor Not Found"}, status: :not_found
    end
end
