require 'rails_helper'

RSpec.describe Problem, type: :model do

  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('title', 'content', 'references')
    end
  end

  describe 'validators' do
    it { should validate_presence_of (:title) }
    it { should validate_presence_of (:content) }
    it { should validate_presence_of (:references) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(80) }
    it { should validate_length_of(:content).is_at_least(5).is_at_most(500) }
    it { should validate_length_of(:references).is_at_least(5).is_at_most(500) }
  end

    describe 'relations' do
    it { should belong_to(:creator) }
    it { should have_many(:comments) }
    it { should have_many(:users).through(:problem_users) }
    it { should have_many(:tags).through(:problem_tags) }
  end

  describe '#current_user_contributor?' do
    let!(:contributor) { create(:user) }
    let(:contributor_two) { create(:user_1) }
    let(:problem_sud) { create(:problem) }

    it 'if user is nil return false' do
      expect(
        problem_sud.current_user_contributor?(nil)
      ).to eq(false)
    end

    context 'passed user not nil' do

      it 'if user is contributor return true' do
        problem_sud.users << contributor
        expect(
          problem_sud.current_user_contributor?(contributor)
        ).to eq(true)
      end

      it 'if problem doesn\'t have contributors then nil' do
        expect(
          problem_sud.current_user_contributor?(contributor)
        ).to eq(nil)
      end

      it 'if current_user is not contributor then nil' do
        problem_sud.users << contributor_two
        expect(
          problem_sud.current_user_contributor?(contributor)
        ).to eq(nil)
      end

    end
  end

  describe '#creator?' do
    let!(:creator) { create(:user) }
    let(:not_creator) { create(:user_1) }
    let(:problem_sud) { create(:problem, creator_id: creator.id) }

    it 'if nil is passed then false' do
      expect(
        problem_sud.creator?(nil)
      ).to eq(false)
    end

    it 'if current_user is not creator then false' do
      expect(
        problem_sud.creator?(not_creator)
      ).to eq(false)
    end

    it 'if current_user is creator then true' do
      expect(
        problem_sud.creator?(creator)
      ).to eq(true)
    end

  end

end
