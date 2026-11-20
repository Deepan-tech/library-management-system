class ServerInfoController < ActionController::Base
  def show
    render plain: "Request handled by #{ENV.fetch('SERVER_ID', 'unknown')}"
  end
end