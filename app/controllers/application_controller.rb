class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def render_err(message=nil, status=403)
    json = {
      success: false,
      message: message
    }
    render json: json, status:status
  end

  def render_json(object, status=200)
    object[:success] = true
    render json: object, status: status
  end
end
