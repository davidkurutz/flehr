module Response
  def json_envelope(obj, status = :ok)
    result = { 'data': obj }
    render json: result , status: status
  end
end