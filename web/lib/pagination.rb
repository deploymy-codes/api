module Pagination

  def cursor
    Cursor.new params[:offset], params[:limit]
  end

end
