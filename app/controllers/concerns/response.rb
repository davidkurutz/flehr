module Response
  def json_envelope(obj, status = :ok)
    result = { 'data': obj }
    render json: result , status: status
  end

  def socket_envelope(obj)
    { 'data': obj }
  end
end