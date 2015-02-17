module Pagination

  def cursor
    @cursor ||= Cursor.new params[:offset], params[:limit]
  end

  def pagination
    headers['X-PER-PAGE'] = cursor.limit
    headers['X-TOTAL-COUNT'] = cursor.total_count

    json serialize(cursor.data)
  end

end
