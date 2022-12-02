class ApplicationController < ActionController::Base
  def current_user
    @first_user = User.all.first
    @first_user
  end
end
