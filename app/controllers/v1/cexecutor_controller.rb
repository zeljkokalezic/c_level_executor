require "base64"

class V1::CexecutorController < V1::BaseController
  def execute
    #TODO: preprocess parameters

    executor = CExecutor.new(Base64.decode64(params[:function]))
    result = nil
    status = 200
    begin
      result = executor.execute(params[:function_name].to_s, params[:params].to_s)
    rescue Exception => ex
      result = ex.message
      status = 500
    end

    json_response(result, status)
  end
end
