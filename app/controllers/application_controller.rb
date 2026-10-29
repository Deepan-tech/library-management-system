class ApplicationController < ActionController::Base
   
  # helper_mothod :require_student

 def require_admin
  unless session[:admin_id]
    redirect_to login_path, alert: "Please log in as an admin."
  end
 end

  allow_browser versions: :modern
  stale_when_importmap_changes
end