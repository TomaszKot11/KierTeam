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

    expect(service.advances_search_on).to eq('on')
    expect(service.lookup).to eq('lookup')
    expect(service.title_on).to eq('on')
    expect(service.content_on).to eq('on')
    expect(service.tag_names).to contain_exactly(['Android'])
    end

    context 'basic search' do

        # it 'should raise error when blank query' do

        # end


    end



end
