class StracticPagesController < ApplicationController
  skip_before_action :require_login
  def top;  end

  def terms_of_service; end
end
