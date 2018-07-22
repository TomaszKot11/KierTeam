require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do
  	before { get :index }

    it { should respond_with(200..300)}
    it { should render_template('index')}

    context 'users' do
    	let(:user1) { create(:user) }
			let(:user2) { create(:user, email:'email2@aa.pl') }

			it 'should return all authors' do
				expect(assigns(:users)).to match_array([user1,user2])
			end
    end
  end

  describe '#show' do
  	let(:user1) { create(:user) }
  	before { get :show, params: {id: user1.id} }

  	it { should respond_with(200..300)}
  	it { should render_template('show')}

  	context 'user' do 
  		it { expect(assigns(:user)).to eq(user1) }
  	end 
	end
	
	describe '#edit' do 
			let(:user1) { create(:user) }

			 it 'user variable should be present' do 
				pending "implement #{__FILE__}"
		 	end
	end

end
