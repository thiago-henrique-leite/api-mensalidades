module Paginable
  extend ActiveSupport::Concern

  def count
    params[:count] || 20
  end

  def page
    params[:page] || 1
  end
end
