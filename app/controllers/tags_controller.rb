class TagsController < ApplicationController
    #TODO: restrict the tag creation only for admin

    def new
        @tag = Tag.new

    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save 
            redirect_to root_path, notice: 'You created tag successfully!'
        else
            render :new
        end
    end

    # TODO: add button somewhere
    def destroy
        @tag = Tag.find(params[:id])        
        @tag.destroy
        redirect_to root_path, alert: 'Selected tag was successfully destroyed!'
    end

    # for managment
    def index
       @tags = Tag.all 
    end

    private 
        def tag_params
            params.require(:tag).permit(:name)
        end

end