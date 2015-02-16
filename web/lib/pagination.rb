module Pagination

  def pager
    Pager.new params[:offset], params[:limit]
  end

end
