require 'rails_helper'

RSpec.describe SlackService do

  it 'initializer should init proper variables' do
    service =  SlackService.new(
        'sample@example.com',
        'Sample Title',
        'Sample Sampowky',
        'https://sample.uk'
         )
         expect(service.instance_variable_get(:@email)).to eq('sample@example.com')
         expect(service.instance_variable_get(:@problem_title)).to eq('Sample Title')
         expect(service.instance_variable_get(:@full_name)).to eq('Sample Sampowky')
         expect(service.instance_variable_get(:@url)).to eq('https://sample.uk')
      end

  # rest functionalities are (almost all) gem-dependent
end