class ApplicationController < ActionController::Base

# The following would be for API only scenario
#class ApplicationController < ActionController::API
#  include ActionController::MimeResponds
#  include ActionController::RequestForgeryProtection

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 
  #protect_from_forgery with: :exception

end

