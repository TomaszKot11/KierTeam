require 'rails_helper'

RSpec.describe SearchingService do

  it 'initializer should init proper variables' do
   service =  SearchingService.new(
        advanced_search_on: 'on',
        lookup: 'lookup',
        title_on: 'on',
        content_on: 'on',
        reference_on: 'on',
        tag_names: [['Android']]
        )
        expect(service.instance_variable_get(:@advances_search_on)).to eq('on')
        expect(service.instance_variable_get(:@lookup)).to eq('lookup')
        expect(service.instance_variable_get(:@title_on)).to eq('on')
        expect(service.instance_variable_get(:@content_on)).to eq('on')
        expect(service.instance_variable_get(:@reference_on)).to eq('on')
        expect(service.instance_variable_get(:@tag_names)).to contain_exactly(['Android'])
     end

    context 'basic search' do
        let(:problem_one) { create(:problem) }
        let(:problem_two) { create(:problem_2) }

        it 'should raise error when blank query' do
            service = SearchingService.new(lookup: '')
            expect {  service.call }.to raise_error(ArgumentError)
        end

        it 'should search using title' do
            problem_two
            service = SearchingService.new(lookup: problem_one.title)
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'should search using content' do
            problem_two
            service = SearchingService.new(lookup: problem_one.content)
            expect(service.call).to contain_exactly(problem_one)
        end
    end

    context 'advanced search' do
        let(:problem_one) { create(:problem) }
        let(:problem_two) { create(:problem_2) }
        let(:tag_one) { create(:tag) }
        let(:tag_two) { create(:tag_1) }

        it 'only advanced_serch_on should return all' do
            service = SearchingService.new(advanced_search_on: 'on', lookup: '')
            problem_one
            problem_two
            expect(service.call).to contain_exactly(problem_one, problem_two)
        end

        it 'only tags searching should return valid data' do
            problem_one.tags << tag_one
            problem_one.tags << tag_two
            problem_two.tags << tag_one
            service = SearchingService.new(advanced_search_on: 'on', lookup: '', tag_names: [[tag_one.name], [tag_two.name]])
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'only references search should give valid data' do
            problem_one
            problem_two
            service = SearchingService.new(advances_search_on: 'on', lookup: problem_one.reference_list, reference_on: 'on')
            expect(service.call).to contain_exactly()
        end

        it 'only content search should give valid data' do
            problem_two
            service = SearchingService.new(advances_search_on: 'on', lookup: problem_one.content, content_on: 'on')
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'tag-reference search should give valid data' do
            problem_one.tags << tag_one
            problem_one.tags << tag_two
            problem_two.tags << tag_one
            service = SearchingService.new(advanced_search_on: 'on', lookup: problem_one.reference_list, reference_on: 'on', tag_names: [[tag_one.name], [tag_two.name]])
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'reference-content search should give valid data' do
            problem_one
            problem_one.update_attributes(reference_list: problem_one.content)
            problem_two
            service = SearchingService.new(lookup: problem_one.content, advanced_search_on: 'on', content_on: 'on', reference_on: 'on')
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'tag-content search should give valid data' do
            problem_one.tags << tag_one
            problem_one.tags << tag_two
            problem_two.tags << tag_one
            service = SearchingService.new(advanced_search_on: 'on', lookup: problem_one.content, content_on: 'on', tag_names: [[tag_one.name], [tag_two.name]])
            expect(service.call).to contain_exactly(problem_one)
        end

        it 'when no lookup present should raise exception when content search' do
            service = SearchingService.new(advanced_search_on: 'on', lookup: '', content_on: 'on')
            expect{ service.call }.to raise_error(ArgumentError)
        end

        it 'when no lookup present should raise exception when reference search' do
            service = SearchingService.new(advanced_search_on: 'on', lookup: '', reference_on: 'on')
            expect{ service.call }.to raise_error(ArgumentError)
        end

        it 'when no lookup present should raise exception when title search' do
            service = SearchingService.new(advanced_search_on: 'on', lookup: '', title_on: 'on')
            expect{ service.call }.to raise_error(ArgumentError)
        end
    end
end
