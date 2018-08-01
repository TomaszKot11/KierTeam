class FilteringService
  def initialize(params = {})
    @problems_col = params[:collection]
    @order = params[:order]
  end

  def call
    filter
  end

  private

  # strange structure because of rubocop
  def filter
    @problems_col.order_title_desc
    case @order
    when /title.+/
      return title_filter(@order, @problems_col)
    when /content.+/
      return content_filter(@order, @problems_col)
    when /updated_.+/
      return updated_at_filter(@order, @problems_col)
    else
      # 404
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  def title_filter(order, problems_cols)
    case order
    when 'title: :desc'
      problems_cols.order_title_desc
    when 'title: :asc'
      problems_cols.order_title_asc
    end
  end

  def content_filter(order, problems_cols)
    case order
    when 'content: :desc'
      problems_cols.order_content_desc
    when 'content: :asc'
      problems_cols.order_content_asc
    end
  end

  def updated_at_filter(order, problems_cols)
    case order
    when 'updated_at: :desc'
      problems_cols.updated_at_desc
    when 'updated_at: :asc'
      problems_cols.updated_at_asc
    end
  end
end
