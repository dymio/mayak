class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # HTTP basis authentication
  #http_basic_authenticate_with name: "proekt", password: "palenin" if Rails.env == 'production'

  # Uncomment lines above if you use not public/404.html page
  #   and render it in the 'not_found' method after in this file

  # rescue_from ActionController::RoutingError,      with: :not_found
  # rescue_from AbstractController::ActionNotFound,  with: :not_found
  # rescue_from ActiveRecord::RecordNotFound,        with: :not_found

  # protected

  # # Call this method if you want show 404 error page instead of any view
  # def not_found
  #   respond_to do |format|
  #     format.html { render file: File.join(Rails.root, 'public', '404.html'),
  #                          layout: false,
  #                          status: 404 }
  #     format.json { render text: '{"error": "not_found"}', status: 404 }
  #   end
  # end
end
