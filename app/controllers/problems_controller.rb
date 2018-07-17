class ProblemsController < ApplicationController
    before_action :require_login, only: [:new]

    def new_logged_user
        @problem = Problem.new
        @currentUser = current_user.id
    end


    def create 
        @problem = Problem.new(problem_params)
        
        if @problem.save 
            redirect_to root_path, notice: 'You created post successfully!'
        else
           render :new
        end
    end

    private 
        # params from form whic are required
        def problem_params
            params.require(:problem).permit(:title, :content, :references, :creator_id)
        end
        # checks if user is logged_in
        def require_login
            unless user_signed_in?
                redirect_to root_path, alert: 'You have to be logged in to create new posts'
            end
        end
end