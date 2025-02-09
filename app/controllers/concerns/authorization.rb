module Authorization
  extend ActiveSupport::Concern

  def require_admin
    unless Current.user&.admin?
      redirect_to root_url, alert: "You are not authorized to access this page."
    end
  end
end
