class VersionsController < ApplicationController
  load_and_authorize_resource

  def index
    @versions = Version.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end
end
