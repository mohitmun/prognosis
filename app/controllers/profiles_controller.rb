class ProfilesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def upload_resume
  	@profile = Profile.new
  end

  def resume_parser
  end
end