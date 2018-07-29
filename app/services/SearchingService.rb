class SearchingService

  # receives searching attributes from
  # controllers
  def initizlize(params)
    @params = params
  end

  def call
    if @params[:advanced_search_on].present?
      problems = perform_advanced_search
    else
      is_lookup = @params[:lookup].present?
      redirect_to root_path, alert: 'Searching query should not be blank!' unless is_lookup
      problems = Problem.default_search(@params[:lookup])
    end
    problems
  end

  private


    # may be inefficient? - all records?
    # long if not to show all records when
    # none option is specified
    def perform_advanced_search
      is_title = @params[:title_on].present?
      is_content = @params[:content_on].present?
      is_lookup = @params[:lookup].present?
      is_reference = @params[:reference_on].present?

      problems_loc = tag_search_without_query

      if is_content || is_title || is_reference
        redirect_to root_path, alert: 'Searching query should not be blank!' unless is_lookup
        problems_loc = perform_text_search(is_title, is_reference, is_content, problems_loc)
      end
      problems_loc
    end

    def perform_text_search(is_title, is_reference, is_content, problems_loc)
      # content
      problems_loc = problems_loc.content_where(@params[:lookup]) if is_content

      # title
      problems_loc = problems_loc.title_where(@params[:lookup]) if is_title

      # references
      problems_loc = problems_loc.reference_where(@params[:lookup]) if is_reference

      problems_loc
    end

    # Tags search is specific beacuse doesn't need any quey to be present
    def tag_search_without_query
      tag_names = @params[:tag_names].present?
      problems_loc = Problem.where(nil)
      @params[:tag_names].each { |tag_name| problems_loc = problems_loc.tag_where(tag_name) } if tag_names
      problems_loc
    end
end