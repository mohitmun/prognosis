class WelcomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
    init_hash
    @profiles = Profile.all
  end

  def profiles
    init_hash
    @profiles = Profile.all
    params.permit!
    params1 = params.slice!(:action, :controller)
    params1.sort_by {|_key, value| value}.to_h
    params1.each do |key, value|
      @hash["#{key}1"] = value.split(",")[0]
      @hash["#{key}2"] = value.split(",")[1]
      @profiles = @profiles.between(key, value.split(",")[0], value.split(",")[1])
    end
    render 'index'
  end

  def init_hash
    @hash = {}
    @hash["commitment1"] = 1
    @hash["commitment2"] = 5
    @hash["dec_making1"] = 1
    @hash["dec_making2"] = 5
    @hash["cap_to_work_independent1"] = 1
    @hash["cap_to_work_independent2"] = 5
    @hash["team_work1"] = 1
    @hash["team_work2"] = 5
  end

end
