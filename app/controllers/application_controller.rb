class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :skip_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  def render_404
    render status: 404, json: { message: "record not found." }
  end

  protected
  def skip_session
    request.session_options[:skip] = true
  end



end
