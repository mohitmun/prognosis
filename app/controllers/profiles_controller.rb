class ProfilesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def upload_resume
  	@profile = Profile.new
  end

  def resume_parser
  	uploaded_file = params[:profile][:resume]
  	dir_name = ""
  	File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    	file.write(uploaded_file.read)
    	dir_name = File.expand_path(file)
  	end
  	rtransducer_path = Rails.root.join('lib', 'assets', 'ResumeParser', 'ResumeTransducer').to_s
  	rparser_path = Rails.root.join('lib', 'assets', 'ResumeParser').to_s
  	#file is stored in Rails.root
  	` java -cp '#{rtransducer_path}/bin/*:#{rparser_path}/GATEFiles/lib/*:#{rparser_path}/GATEFiles/bin/gate.jar:#{rtransducer_path}/lib/*' code4goal.antony.resumeparser.ResumeParserProgram #{dir_name} yolo`
  	@resume_hash = `cat #{Rails.root}/yolo`
  	@resume_hash = JSON.parse @resume_hash.gsub('=>', ':')
  	#basics normally gives crap TODO I guess
  	@resume_hash = @resume_hash.except "basics"
  end

  def create
  	@profile = Profile.new()
  	@profile.skills = params["skills"]
  	@profile.qualification = params["education"]
  	@profile.education = params["text"]
  	@profile.save

  	redirect_to :root
  end
end