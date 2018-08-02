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
      is_lookup = @lookup.empty?
      raise ArgumentError, 'Query may not be blank' if is_lookup
      problems = Problem.default_search(@lookup)
    end
    problems
  end

  private

  def perform_advanced_search
    is_title = !@title_on.nil?
    is_content = !@content_on.nil?
    is_lookup = @lookup.empty?
    is_reference = !@reference_on.nil?

    problems_loc = tag_search_without_query
    if is_content || is_title || is_reference

      raise ArgumentError, 'Query may not be blank' if is_lookup

      problems_loc = perform_text_search(is_title, is_reference, is_content, problems_loc)
    end
    problems_loc
  end

  def perform_text_search(is_title, is_reference, is_content, problems_loc)
    # content
    problems_loc = problems_loc.content_where(@lookup)  if is_content

    # title
    problems_loc = problems_loc.title_where(@lookup) if is_title

    problems_loc = problems_loc.reference_where(@lookup) if is_reference

    problems_loc
  end

  # Tags search is specific beacuse doesn't need any quey to be present
  def tag_search_without_query
    tag_names = @tag_names.nil?
    problems_loc = Problem.where(nil)
    @tag_names.each { |tag_name| problems_loc = problems_loc.tag_where(tag_name) } unless tag_names
    problems_loc
  end
end
