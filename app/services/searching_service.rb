class SearchingService
  def initialize(params = {})
    @advances_search_on = params[:advanced_search_on]
    @lookup = params[:lookup]
    @title_on = params[:title_on]
    @content_on = params[:content_on]
    @reference_on = params[:reference_on]
    @tag_names = params[:tag_names]
  end

  def call
    problems = if @advances_search_on.nil?
                 perform_default_search
               else
                 perform_advanced_search
               end

    problems
  end

  private

  def perform_default_search
    is_lookup = @lookup.empty?
    raise ArgumentError, 'Query may not be blank' if is_lookup
    after_split = split_searching_phrase
    problems = Problem.none
    after_split.each do |word|
      searched = Problem.default_search(word.downcase)
      problems = problems.or(searched)
    end
    problems
  end

  def split_searching_phrase
    @lookup.split(' ')
  end

  def perform_advanced_search
    is_title = !@title_on.nil?
    is_content = !@content_on.nil?
    is_lookup = @lookup.empty?
    is_reference = !@reference_on.nil?

    problems_loc = tag_search_without_query
    if is_content || is_title || is_reference

      raise ArgumentError, 'Query may not be blank' if is_lookup

      after_split = split_searching_phrase
      after_split.each do |word|
        problems_returned = perform_text_search(word.downcase, is_title, is_reference, is_content)
        problems_loc = problems_loc.or(problems_returned)
      end
    end
    problems_loc
  end

  def perform_text_search(phrase, is_title, is_reference, is_content)
    problem_seed = Problem.none
    problem_seed = problem_seed.or(Problem.reference_where(phrase)) if is_reference
    problem_seed = problem_seed.or(Problem.title_where(phrase)) if is_title
    problem_seed = problem_seed.or(Problem.content_where(phrase)) if is_content

    problem_seed
  end

  # Tags search is specific beacuse doesn't need any query to be present
  def tag_search_without_query
    tag_names = @tag_names.nil?
    unless tag_names
      problems_loc = Problem.all
      @tag_names.each { |tag_name| problems_loc = problems_loc.tag_where(tag_name) }
      return problems_loc
    end
    Problem.none
  end
end
