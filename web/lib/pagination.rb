module Pagination

  def cursor
    @cursor ||= Cursor.new params[:offset], params[:limit]
  end

  def paginate(envelope)
    headers['X-LIMIT']       = cursor.limit
    headers['X-TOTAL-COUNT'] = envelope.total_count
    headers['Link']          = link_headers(envelope)

    json serialize(envelope.data)
  end

  private

  def request_url
    @request_url ||= request.url.split("?")[0]
  end

  def link_headers(envelope)
    links = []

    if envelope.previous_offset?
      links << %(<#{request_url}?offset=#{envelope.previous_offset}&limit=#{envelope.limit}>; rel="prev")
    end

    if envelope.next_offset?
      links << %(<#{request_url}?offset=#{envelope.next_offset}&limit=#{envelope.limit}>; rel="next")
    end

    if !envelope.first? && envelope.next_offset?
      links << %(<#{request_url}?offset=0&limit=#{envelope.limit}>; rel="first")
    end

    if !envelope.last? && envelope.previous_offset?
      links << %(<#{request_url}?offset=#{envelope.last_offset}&limit=#{envelope.limit}>; rel="last")
    end

    links.join ','
  end

end
