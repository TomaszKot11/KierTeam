require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe RemoveOldAuthors, type: :job do
	Sidekiq::Testing.inline!

	#Sprawdzamy czy job jest odłożony na kolejce
		
end