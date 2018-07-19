class ProblemsController < ApplicationController
   
    before_action :authenticate_user!, :only => [:new_logged_user, :create]

    def index
        @problems = Problem.all
    end


    # FOR USER LOG IN CREATION
    def new_logged_user
        @problem = Problem.new
        @all_users_mapped = User.all.map { |p| [ "#{p.name} #{p.surname}", p.id ] }
    end


    def create 
        @problem = Problem.new(problem_params.merge(creator_id: current_user.id))
        @all_users_mapped = User.all.map { |p| [ "#{p.name} #{p.surname}", p.id ] }
        

        if @problem.save 
            redirect_to root_path, notice: 'You created post successfully!'
        else
           render :new_logged_user
        end
    end

    # searches for problems
    def search_problems
        query = params[:lookup]
        if query.blank? != true 
            # to avoid SQL Injection
            @problems = Problem.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%").paginate(:per_page => 5, :page => params[:page])
        else
            redirect_to root_path, alert: 'Searching query should not be blank!'
        end
    end

    # show specific problem
    def show 
        @problem = Problem.find(params[:id])
    end

    # # simply appends the new contributor in problem creation
    # def add_collaborator
    #     id = params[:user_id]
    #     @user_chosen = User.find(id)
    # end

    private 
        # params from form whic are required
        def problem_params
            params.require(:problem).permit(:title, :content, :references, problem_users_attributes: [:id, :user_id])
        end
end