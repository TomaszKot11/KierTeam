class ProblemsController < ApplicationController
   
    before_action :authenticate_user!, :only => [:new_logged_user, :create]

    # FOR USER LOG IN CREATION
    def new_logged_user
        @problem = Problem.new
    end


    def create 
        @problem = Problem.new(problem_params.merge(creator_id: current_user.id))
        
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
            params.require(:problem).permit(:title, :content, :references)
        end
end