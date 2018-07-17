class ProblemsController < ApplicationController
    before_action :require_login, only: [:new]

    # FOR USER LOG IN CREATION
    def new_logged_user
        @problem = Problem.new
        @current_user = current_user.id
    end


    def create 
        @problem = Problem.new(problem_params)
        
        if @problem.save 
            redirect_to root_path, notice: 'You created post successfully!'
        else
           render :new
        end
    end

    # searches for problems
    def search_problems
        query = params[:lookup]
        if query.blank? != true    
            # to avoid SQL Injection
            @problems = Problem.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
        else
            redirect_to root_path, alert: 'Searching query should not be blank!'
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