class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        students = Student.all 
        render json: students
    end

    def show
        student = student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {error: "validation failed"}, status: :unprocessable_entity
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: {error: "Student Not Found"}, status: :not_found
    end
end
