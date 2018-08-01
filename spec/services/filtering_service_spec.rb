require 'rails_helper'

RSpec.describe FilteringService do
  let(:problem_a) { create(:problem) }
  let(:problem_b) { create(:problem_2) }
  let(:problem_c) { create(:problem_2) }

  it 'initializer should init proper variables' do
    service =  FilteringService.new(
             collection: [problem_a],
             order: 'title: :desc'
             )
    expect(service.instance_variable_get(:@problems_col)).not_to be_nil
    expect(service.instance_variable_get(:@order)).not_to be_nil
  end

  context 'filtering testing' do

     it 'should filter desc title' do
      service = FilteringService.new(
        collection: Problem.all,
        order: 'title: :desc'
      )
      # will be deprecated in Rails 6.0
      ordered = Problem.order(Arel.sql('title DESC'))
      expect(service.call.to_a).to eq(ordered.to_a)
    end

    it 'should filter asc title' do
      service = FilteringService.new(
        collection: Problem.all,
        order: 'title: :asc'
      )
      # will be deprecated in Rails 6.0
      ordered = Problem.order(Arel.sql('title ASC'))
      expect(service.call.to_a).to eq(ordered.to_a)
    end

    it 'should filter desc content' do
      service = FilteringService.new(
        collection: Problem.all,
        order: 'content: :asc'
      )
      # will be deprecated in Rails 6.0
      ordered = Problem.order(Arel.sql('content ASC'))
      expect(service.call.to_a).to eq(ordered.to_a)
    end

    it 'should filter updated_at desc' do
      service = FilteringService.new(
        collection: Problem.all,
        order: 'updated_at: :desc'
      )
      # will be deprecated in Rails 6.0
      ordered = Problem.order(Arel.sql('updated_at DESC'))
      expect(service.call.to_a).to eq(ordered.to_a)
    end

    it 'should filter updated_at asc' do
      service = FilteringService.new(
        collection: Problem.all,
        order: 'updated_at: :asc'
      )
      # will be deprecated in Rails 6.0
      ordered = Problem.order(Arel.sql('updated_at ASC'))
      expect(service.call.to_a).to eq(ordered.to_a)
    end
  end
end
