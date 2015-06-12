class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  # Used to implemet page-specific actions such as adding specific css rules
  def page_code
  	0
  end

  # This is default.
  # Add the same action to a any controller to set the page_title acordingly
  def page_title
  	"PatTalk"
  end

  private

  # Designed to handle a permission error in statuses controller test when updating statuses (line ~100)
  # Error was can't mass assign protected attributes, now it is redirecting to the error page
  def render_permission_error
  	render file: 'public/permission_error', status: :error, layout: false
  end

  def render_404
    render file: 'public/404', status: :not_found
  end



end
