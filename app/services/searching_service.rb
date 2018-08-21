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
    if !@advances_search_on.nil?
      problems = perform_advanced_search
    else
      problems = perform_defauls_search
    end
    problems
  end

  private

  def perform_defauls_search
    is_lookup = @lookup.empty?
    raise ArgumentError, 'Query may not be blank' if is_lookup
    after_split = split_searching_phrase
    problems = Problem.none
    after_split.each do |word|
      searched = Problem.default_search(word)
      problems = problems.or(searched)
    end
    problems
  end

  def split_searching_phrase
    after_split = @lookup.split(" ")
    result = Problem.none
    after_split
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
        problems_returned = perform_text_search(word, is_title, is_reference, is_content)
        problems_loc = problems_loc.or(problems_returned)
        # byebug
        problems_loc
      end
    end
    problems_loc
  end

  def perform_text_search(phrase, is_title, is_reference, is_content)
    # content
    problems_loc = problems_loc.content_where(phrase) if is_content

    # title
    # problems_loc = problems_loc.title_where(phrase) if is_title
    # problems_loc = problems_loc.title_where(phrase) if is_title
    # if is_title
    #   p 'Wykonuje title_where'
    #   p '#######'
    #   p problems_loc
    #   p '#######'
    #   p 'LLLLL'
    #   p Problem.title_where(phrase)
    #   p 'LLLLL'
    #   problems_loc = problems_loc.title_where(phrase)
    # end

    # p '!!!!'
    # p problems_loc
    # p is_title
    # p '!!!!'
    # # refereneces
    # Problem.reference_where(phrase)
    # problems_loc = problems_loc.reference_where(phrase) if is_reference
    problems_reference = Problem.reference_where(phrase) if is_reference
    problems_title = Problem.title_where(phrase) if is_title
    problems_content = Problem.content_where(phrase) if is_content
    problems_reference.or(problems_title).or(problems_content)
    # problems_loc
  end

  # Tags search is specific beacuse doesn't need any query to be present
  def tag_search_without_query
    tag_names = @tag_names.nil?
    problems_loc = Problem.none
    @tag_names.each { |tag_name| problems_loc = problems_loc.tag_where(tag_name) } unless tag_names
    problems_loc
    # byebug
    # problems_loc
  end
end
