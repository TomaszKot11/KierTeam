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

    # for adding many contributors
    def add_contributor
        @all_users_mapped = User.all.map { |p| [ "#{p.name} #{p.surname}", p.id ] }
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
        @user=current_user
        @comment = Comment.new
        @creator_id = @problem.creator.id
        # methods can't be too long ;) 
        @is_current_contributor = is_current_user_contributor()
        @is_creator = check_if_creator()
        if @problem.comments.any?
          @comments = Comment.where(problem_id: params[:id]).order(created_at: :desc)
        else
          @comments = nil
        end

        @users = User.all
        if params[:errors]
          @comment_errors = params[:errors]
        else
          @comment_errors = {}
        end
     end

     def destroy 
        @problem = Problem.find(params[:id])        
        @problem.destroy
        redirect_to root_path, alert: 'Your problem was successfully destroyed!'
    end


    private 
        # params from form whic are required
        def problem_params
            # this is tested using capybara
            params.require(:problem).permit(:title, :content, :references,:tag_ids => [], problem_users_attributes: [:id, :user_id])
        end

        # checks whether the current logged user is contributor to showed 
        # problem and can add comments
        def is_current_user_contributor
            @contributors = @problem.users
            @contributors.each  do |contributor|  
                if contributor.id == current_user.id
                    return true
                end
            end
            false
        end

        def check_if_creator
            ( current_user.id == @problem.creator_id ) ? true : false
       
        end
end