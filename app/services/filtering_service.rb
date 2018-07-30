class FilteringService

  def initialize(params = {})
    @problems_col = params[:collection]
    @order = params[:order]
  end

  def call
    filter
  end

  private

  def filter
    @problems_col.order_title_desc
    case @order
    when 'title: :desc'
      return @problems_col.order_title_desc
    when 'title: :asc'
      return @problems_col.order_title_asc
    when 'content: :desc'
      return @problems_col.order_content_desc
    when 'content: :asc'
      return @problems_col.order_content_asc
    when 'updated_at: :asc'
      return @problems_col.updated_at_asc
    when 'updated_at: :desc'
      return @problems_col.updated_at_desc
    else
      # 404
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
