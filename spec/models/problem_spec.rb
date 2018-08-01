require 'rails_helper'

RSpec.describe Problem, type: :model do

  describe 'attributes' do
    it 'should have proper attributes' do
      expect(subject.attributes).to include('title', 'content', 'reference_list')
    end
  end

  describe 'validators' do
    it { should validate_presence_of (:title) }
    it { should validate_presence_of (:content) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(160) }
    it { should validate_length_of(:content).is_at_least(5).is_at_most(1500) }
  end

  describe 'relations' do
    it { should belong_to(:creator) }
    it { should have_many(:comments) }
    it { should have_many(:users).through(:problem_users) }
    it { should have_many(:tags).through(:problem_tags) }
  end

  describe 'scopes' do

    let!(:problem_one) { create(:problem) }
    let!(:problem_two) { create(:problem_2) }
    let(:tag_one) { create(:tag) }
    let(:tag_two) { create(:tag_1) }

    it 'should have working default_search' do
      expect(
        Problem.default_search(problem_one.title)
      ).to contain_exactly(problem_one)

      expect(
        Problem.default_search(problem_two.content)
      ).to contain_exactly(problem_two)
    end

    it 'should have working reference_where' do
      expect(
        Problem.reference_where(problem_one.reference_list)
      ).to contain_exactly(problem_one)
    end


    it 'should have working tag_where' do
      problem_one.tags << tag_one
      problem_two.tags << tag_two
      expect(
        Problem.tag_where(tag_one.name)
      ).to contain_exactly(problem_one)

      expect(
        Problem.tag_where(tag_one.name)
      ).not_to include(problem_two)

      expect(
        Problem.tag_where(tag_two.name)
      ).to contain_exactly(problem_two)
    end

    it 'should have working content_where' do
      sub_content = problem_one.content[0..3]
      expect(
        Problem.content_where(sub_content)
      ).to contain_exactly(problem_one)
    end

    it 'should have working title_where' do
      sub_title = problem_one.title[0..3]
      expect(
        Problem.title_where(sub_title)
      ).to contain_exactly(problem_one)
    end

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
