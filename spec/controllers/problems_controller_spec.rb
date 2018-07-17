require 'rails_helper'


RSpec.describe ProblemsController, type: :controller do 

    describe 'template rendering' do 

        let(:user_sud) { create(:user)}

        it 'not logged user should be restricted from creating new problems' do 
            get :new_logged_user
            expect(response).to redirect_to(new_user_session_path)
        end

        it 'logged in user should be able to create new post' do 
            # we confirm the user registration
            user_sud.confirm
            sign_in(user_sud)

           # get :new_logged_user
            #expect(response).to redirect_to(new_user_session_path)
       
        end


    end
end