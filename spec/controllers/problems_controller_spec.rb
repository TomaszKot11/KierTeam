require 'rails_helper'


RSpec.describe ProblemsController, type: :controller do 

    describe 'template rendering' do 

        let(:author_sud) { create(:author)}

        it 'not logged user should be restricted from creating new problems' do 
            get :new_logged_user
            expect(response).to redirect_to(new_user_session_path)
        end

        


     
    end
end